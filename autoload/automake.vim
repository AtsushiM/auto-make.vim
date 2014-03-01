"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/auto-make.vim
"VERSION:  0.9
"LICENSE:  MIT

let s:save_cpo = &cpo
set cpo&vim

let g:auto_make_plugindir = expand('<sfile>:p:h:h').'/'
let g:auto_make_templatedir = g:auto_make_plugindir.'template/'
let g:auto_make_stoptext = '# auto-make stopped.'

if !exists("g:auto_make_cdloop")
    let g:auto_make_cdloop = 5
endif
if !exists("g:auto_make_makefile")
    let g:auto_make_makefile = 'Makefile'
endif
if !exists("g:auto_make_cmd")
    let g:auto_make_cmd = 'make&'
endif
if !exists("g:auto_make_manural_cmd")
    let g:auto_make_manural_cmd = 'make'
endif
if !exists("g:auto_make_makefiledir")
    let g:auto_make_makefiledir = $HOME.'/.automake/'
endif

if !isdirectory(g:auto_make_makefiledir)
    call mkdir(g:auto_make_makefiledir)
    call system('cp '.g:auto_make_templatedir.'* '.g:auto_make_makefiledir)
endif

function! automake#Stop()
    let dir = automake#Search()
    let filename = dir.g:auto_make_makefile

    let makefile = readfile(filename)

    if makefile[0] != g:auto_make_stoptext
        let makefile = insert(makefile, g:auto_make_stoptext)
        call writefile(makefile, filename)
    endif
endfunction

function! automake#Play()
    let dir = automake#Search()
    let filename = dir.g:auto_make_makefile

    let makefile = readfile(filename)

    if makefile[0] == g:auto_make_stoptext
        call remove(makefile, 0)
        call writefile(makefile, filename)
    endif
endfunction

function! automake#Pause()
    let g:auto_make_pause = 1
endfunction

function! automake#Resume()
    let g:auto_make_pause = 0
endfunction

function! automake#Search()
    return searchparent#File(g:auto_make_makefile)
endfunction

function! automake#Make()
    let dir = automake#Search()
    if dir != '' && g:auto_make_pause == 0
        let org = getcwd()
        exec 'silent cd '.dir

        let makefile = readfile(g:auto_make_makefile)
        if makefile[0] != g:auto_make_stoptext
            silent call system(g:auto_make_cmd)
        endif

        exec 'silent cd '.org
    endif

endfunction

function! automake#ManualMake()
    let dir = automake#Search()
    if dir != ''
        let org = getcwd()
        exec 'silent cd '.dir
        let er = system(g:auto_make_manural_cmd)
        exec 'silent cd '.org

        if er != ''
            setlocal errorformat=%f:%l:%m
            cgetexpr er
            copen
        else
            copen
        endif
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

function! automake#SRCUpdate()
    let dir = automake#Search()
    if dir != ''
        let file = readfile(dir.g:auto_make_makefile)
        let srcs = join(reverse(split(glob(expand('%:h').'/*.js', "\n"))), ' ')

        let file[0] = 'SRC = '.srcs

        call writefile(file, dir.g:auto_make_makefile)
    endif
endfunction

let &cpo = s:save_cpo
