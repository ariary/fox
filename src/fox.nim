import terminal
import os
import system
import std/strutils

let args = commandLineParams()
var sendFilename: string
if len(args)>0:
  if not fileExists(args[0]):
    echo args[0], " is not a file!"
    quit(92)
  else:
    sendFilename = args[0].split('/')[^1]
else:
  if not isatty(stdin):
    sendFilename = "fox"
  

if sendFilename != "":
  # send
  # Launch server
  styledEcho sendFilename, styleBright, fgCyan, " 🦊 sent!", resetStyle
else:
  # receive
  # Launch server
  styledEcho styleBright, fgGreen, "🦊 received!",resetStyle


# Server function start a server and stop after first request received