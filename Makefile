build.fox:
	nim -d:release -o:bin/fox c src/fox.nim
buildAndRun.fox.receive:
	nim -o:bin/fox c -r src/fox.nim
buildAndRun.fox.send:
	nim -o:bin/fox c -r src/fox.nim ../fox/LICENSE
buildAndRun.fox.send2:
	cat LICENSE | nim -o:bin/fox c -r src/fox.nim