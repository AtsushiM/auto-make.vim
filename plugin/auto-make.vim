"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/auto-make.vim
"VERSION:  0.9
"LICENSE:  MIT

let g:auto_make_plugindir = expand('<sfile>:p:h:h').'/'
let g:auto_make_templatedir = g:auto_make_plugindir.'template/'

if !exists("g:auto_make_file")
    let g:auto_make_file = []
endif
if !exists("g:auto_make_cdloop")
    let g:auto_make_cdloop = 5
endif
if !exists("g:auto_make_cdloop")
    let g:auto_make_cdloop = 5
endif
if !exists("g:auto_make_makefile")
    let g:auto_make_makefile = 'Makefile'
endif
if !exists("g:auto_make_cmd")
    let g:auto_make_cmd = 'make&'
endif
if !exists("g:auto_make_makefiledir")
    let g:auto_make_makefiledir = $HOME.'/.automake/'
endif

if !isdirectory(g:auto_make_makefiledir)
    call mkdir(g:auto_make_makefiledir)
    call system('cp '.g:auto_make_templatedir.'* '.g:auto_make_makefiledir)
endif

command! AutoMakeEdit call automake#Edit()
command! AutoMakeCreate call automake#Create()
command! AutoMakeTemplate call automake#Template()

" auto make
function! s:SetAutoCmd(files)
    if type(a:files) != 3
        let file = [a:files]
    else
        let file = a:files
    endif

    if file != []
        for e in file
            exec 'au BufWritePost *.'.e.' call automake#Make()'
        endfor
    endif
endfunction
au VimEnter * call s:SetAutoCmd(g:auto_make_file)
