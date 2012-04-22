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

command! ManualMake call automake#ManualMake()
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
    unlet file
endfunction
au VimEnter * call s:SetAutoCmd(g:auto_make_file)

let &cpo = s:save_cpo
unlet s:save_cpo
