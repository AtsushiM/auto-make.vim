"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/auto-make.vim
"VERSION:  0.9
"LICENSE:  MIT

let s:save_cpo = &cpo
set cpo&vim

let g:auto_make_plugindir = expand('<sfile>:p:h:h').'/'
let g:auto_make_templatedir = g:auto_make_plugindir.'template/'
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

function! automake#Search()
    let i = 0
    let dir = expand('%:p:h').'/'
    while i < g:auto_make_cdloop
        if !filereadable(dir.g:auto_make_makefile)
            let i = i + 1
            let dir = dir.'../'
        else
            break
        endif
    endwhile

    if i != g:auto_make_cdloop
        return dir
    endif
    return ''
endfunction

function! automake#Make()
    let dir = automake#Search()
    if dir != ''
        let org = getcwd()
        exec 'silent cd '.dir
        silent call system(g:auto_make_cmd)
        exec 'silent cd '.org
    endif
endfunction

function! automake#Edit()
    let dir = automake#Search()
    if dir != ''
        exec 'e '.dir.g:auto_make_makefile
    endif
endfunction

function! automake#Template()
    if !filereadable(g:auto_make_makefiledir.g:auto_make_makefile)
        let org = getcwd()
        exec 'cd '.g:auto_make_makefiledir
        call writefile([], g:auto_make_makefile)
        exec 'cd '.org
    endif

    exec 'e '.g:auto_make_makefiledir.g:auto_make_makefile
endfunction

function! automake#Create()
    if !filereadable(g:auto_make_makefile)
        if filereadable(g:auto_make_makefiledir.g:auto_make_makefile)
            call writefile(readfile(g:auto_make_makefiledir.g:auto_make_makefile), g:auto_make_makefile)
        else
            call writefile([], g:auto_make_makefile)
        endif
        exec 'e '.g:auto_make_makefile
    endif
endfunction

let &cpo = s:save_cpo
