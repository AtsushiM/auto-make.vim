"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/auto-make.vim
"VERSION:  0.9
"LICENSE:  MIT

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