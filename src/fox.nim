import terminal

if isatty(stdin):
  # receive
  # Launch server
  styledEcho styleBright, Green, "🦊 received!"
else:
  # send
  # Launch server
  styledEcho styleBright, bgCyan, "🦊 sent!"


# Server function start a server and stop after first request received