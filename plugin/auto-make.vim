"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/auto-make.vim
"VERSION:  0.9
"LICENSE:  MIT

if exists("g:loaded_auto_make")
    finish
endif
let g:loaded_auto_make = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists("g:auto_make_file")
    let g:auto_make_file = ['*']
endif
if !exists("g:auto_make_update_ext")
    let g:auto_make_update_ext = ''
endif
if !exists("g:auto_make_pause")
    let g:auto_make_pause = 0
endif

command! ManualMake call automake#ManualMake()
command! AutoMakeEdit call automake#Edit()
command! AutoMakeCreate call automake#Create()
command! AutoMakeTemplate call automake#Template()
command! AutoMakePause call automake#Pause()
command! AutoMakeResume call automake#Resume()
command! AutoMakeStop call automake#Stop()
command! AutoMakePlay call automake#Play()

" auto
" function! s:SetAutoSRC(ext)
"     let ext = a:ext
"
"     if file != ''
"         exec 'au BufWritePost *.'.ext.' call automake#SRCUpdate()'
"     endif
"     unlet ext
" endfunction
" au VimEnter * call s:SetAutoSRC(g:auto_make_update_ext)
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
    unlet file
endfunction
au VimEnter * call s:SetAutoCmd(g:auto_make_file)

let &cpo = s:save_cpo
unlet s:save_cpo
