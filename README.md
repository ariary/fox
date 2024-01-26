# fox 🦊

Quickest and easiest single file sharing requiring only `curl` on remote *(light [`gitar`](https://github.com/ariary/gitar))*

*In less of 100 lines of Nim code* 

## send

```shell
fox [file] # or fox < [file]
```
Then paste on target

## receive

```shell
fox
```
Then paste on target + append filename

------
`💾` Support: MacOSX

`⚙️` Requirements: ngrok, pbpaste
```
alias nfoxr='(ngrok http 9292 > /dev/null &); fox;kill -9 $(pgrep ngrok)'
alias nfoxs='f(){ (ngrok http 9292 > /dev/null &); fox ${1};kill -9 $(pgrep ngrok);  unset -f f; }; f'
```