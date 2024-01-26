## next steps
* get first args and read file from it
* copy paste things to clipboard
* paste according curl command to clipboard
* perform http requests
* do the "find external hostname" function (for now only try ngrok endpoint to retrieve ngrok name otherwise 127.1
* try to retrieve filebame from command line (if send)
* http server that we can kill (after first request)
* (brainstorm) time computing (+ stats see compared to usual maybe stored times in ~/.fox)


  
## other ideas/notes
* ✔️ for receive: find curl command that send a file by pipe in it or curl < file
(cf https://realguess.net/2015/08/23/curl-read-from-file-or-stdin/): `curl -XPOST --data-binary @- <`
* ultime alias: `(ngrok http 9292 &); fox && kill -9 $(pidof ngrok)`
* try to not hvae more than 100 lines
