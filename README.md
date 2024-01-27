
<div align=center>
  <h1>fox</h1>
  <img src=./IMG_4212.jpeg width=40%><br>
  <strong>Quickest and easiest single file sharing requiring only <code>curl</code> on remote</strong><br>
    <i>In less than 100 lines of Nim code</i>
</div>

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
```
alias nfoxr='(ngrok http 9292 > /dev/null &); sleep 0.3; fox;kill -9 $(pgrep ngrok)'
alias nfoxs='f(){ (ngrok http 9292 > /dev/null &); sleep 0.3; fox ${1};kill -9 $(pgrep ngrok);  unset -f f; }; f'
```
> `⚙️` Support: MacOSX (pbcopy)


