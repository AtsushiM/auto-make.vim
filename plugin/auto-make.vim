"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/auto-make.vim
"VERSION:  0.9
"LICENSE:  MIT

if !exists("g:auto_make_file")
    let g:auto_make_file = []
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

" auto make
function! s:SetAutoCmd()
    if type(g:auto_make_file) != 3
        let file = [g:auto_make_file]
    else
        let file = g:auto_make_file
    endif

    if file != []
        for e in file
            exec 'au BufWritePost *.'.e.' call automake#Make()'
        endfor
    endif
endfunction
au VimEnter * call s:SetAutoCmd()
