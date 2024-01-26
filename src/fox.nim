import httpcore
import os
import osproc
import std/asynchttpserver
import std/asyncdispatch
import std/httpclient
import std/json
import std/mimetypes
import std/strutils
import std/strformat
import system
import terminal

proc getRemoteCommand(url, sendfilename: string): string =
  if sendfilename.len != 0:
    "curl -s $1 > $2" % [$url, $sendfilename]
  else:
    fmt"""f(){{ curl {url}/$1 -XPOST --data-binary @${{1}};  unset -f f; }};f""" # double { to escape them
#    "curl -s $1 -XPOST --data-binary @- <" % [$url] # you just have to write filename
  
proc copyCommand(cmd: string): string = 
  when system.hostOS == "macosx":
    discard execCmdEx("pbcopy",input = cmd)
  else:
    styledEcho styledDim, "paste on remote: ", resetStyle, cmd

proc getUrl(): string =
  var client = newHttpClient()
  try:
    let ngrokresponse = parseJson(client.getContent("http://127.0.0.1:4040/api/tunnels"))
    return ngrokresponse["tunnels"][0]["public_url"].getStr
  except CatchableError: discard # ignore if ngrok not responding
  finally:
    client.close()
  "http://127.1:9292"

proc sendFile(req: Request, fullpath: string) {.async.} =
  var ext = fullpath.splitFile.ext
  if ext == "": ext = ".txt" else: ext = ext[1 .. ^1]
  let mimetype = newMimetypes().getMimetype(ext.toLowerAscii)
  var file = fullpath.readFile
  await req.respond(Http200, file, {"Content-Type": mimetype}.newHttpHeaders())

proc receiveFile(req: Request) {.async.} =
  writeFile(req.url.path.split('/')[^1],req.body)
  await req.respond(Http200, "🫡")

proc foxServe(fullpath:string){.async.} =
  var server = newAsyncHttpServer()
  proc foxCallback(req: Request) {.async.} =
    if req.reqMethod == HttpGet:
      await sendFile(req,fullpath)
    else:
      await receiveFile(req)
  server.listen(Port(9292))
  let port = server.getPort
  stdout.styledWriteLine("📤 Sending filename... ",styleDim,"paste command on remote")
  await server.acceptRequest(foxCallback)
  await sleepAsync(1) #get only 1 request then close
  server.close()


let args = commandLineParams()
if args.len > 0 and not fileExists(args[0]):
    echo args[0], " is not a file!"
    quit(92)

var fullpath = if args.len > 0: args[0] else: ""
var sendfilename = if fullpath.len > 0 : fullpath.split('/')[^1] elif not isatty(stdin): "fox" else: ""

var command = getRemoteCommand(getUrl(),sendfilename)
stdout.write copyCommand(command)  # echo nothing is copy/paste is handling

waitFor foxServe(fullpath)

cursorUp 1
eraseLine()
if sendfilename.len != 0:
  styledEcho fgCyan, "sent! 🦊", resetStyle
else:
  styledEcho fgGreen, "received! 🦊",resetStyle