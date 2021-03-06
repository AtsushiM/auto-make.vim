# auto-make.vim
ファイル保存時、自動的にmakeコマンドを実行するプラグインです。
編集したファイルからディレクトリを遡ってMakefileが存在した時点でmakeコマンドを実行します。

# install
```
NeoBundle 'AtsushiM/search-parent.vim'
NeoBundle 'AtsushiM/auto-make.vim'
```

デフォルトでは拡張子に関係なく、ファイル保存時にmakeコマンドが実行されます

# コマンド
## :AutoMakeCreate
現在のディレクトリにMakefileを作成します

## :AutoMakeEdit
auto-make.vimでmakeされるMakefileを検索し、開きます
Makefileが存在しない場合、何もしません

## :AutoMakeTemplate
AutoMakeCreateで生成されるMakefileのテンプレートを編集します

## :AutoMakePause
AutoMakeを一時的に停止します。
Vimを再起動した場合、一時停止は解除されます。

## :AutoMakeResume
AutoMakeの一時停止を解除します。

## :AutoMakeStop
現在ファイルから実行されるAutoMakeを停止します。
Makefileの1行目に
```
# auto-make stopped.
```
の行が追加されます。

## :AutoMakePlay
現在ファイルから実行されるAutoMakeを停止を解除します。
Makefileの1行目が
```
# auto-make stopped.
```
となっていた場合、この行が取り除かれます。


# 設定例
```
" 指定した拡張子のファイル保存時にmake実行
" 例：jsファイルで実行する場合
let g:auto_make_file = ['js']

" 例：js,phpで実行する場合
let g:auto_make_file = ['js', 'php']

" ディレクトリを遡る最大数
let g:auto_make_cdloop = 5

" 発見した場合にmakeコマンドを実行
let g:auto_make_makefile = 'Makefile'

" 実行するコマンド
" エラー表示なし(バックエンド実行)
let g:auto_make_cmd = 'make&'

" エラー表示あり
let g:auto_make_cmd = 'make'

" growlで通知(要：growlnotifyインストール)
let g:auto_make_cmd = "make|growlnotify -t 'auto-make' -m 'make complete.'&"
```
