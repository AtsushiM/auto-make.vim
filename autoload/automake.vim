"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/auto-make.vim
"VERSION:  0.9
"LICENSE:  MIT

function! automake#Make()
    let i = 0
    let org = getcwd()
    let dir = expand('%:p:h').'/'
    while i < g:auto_make_cdloop
        if !filereadable(dir.g:auto_make_makefile)
            let i = i + 1
            let dir = dir.'../'
        else
            exec 'silent cd '.dir
            silent call system(g:auto_make_cmd)
            exec 'silent cd '.org
            break
        endif
    endwhile
endfunction
