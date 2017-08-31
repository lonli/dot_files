"behaviour
set nocompatible
set backup

"display
syntax on
set number
set linebreak
set showcmd
set showmatch
set cursorline

"indent
set tabstop=8
"set expandtab
set softtabstop=4

%retab
filetype plugin indent on
set autoindent
set shiftwidth=4

"fold
set foldmethod=indent
set foldlevel=100     "default value 0 make some trouble

"search
set hlsearch
set incsearch
set ignorecase smartcase

"initial
autocmd BufNewFile *.sh,*.py,*.c,*.cc call Initial()
function Initial()
    let l:start_no = 0
    let l:ft = expand("%:e")
    if "sh" == l:ft
        call append(l:start_no, ["\#!/bin/bash", "", ""])
        call cursor(3, 1)
    elseif "py" == l:ft
        call append(l:start_no, ["\#!/usr/bin/env python3", "", ""])
        call cursor(3, 1)
    elseif "c" == l:ft || "cc" == l:ft
        let l:cont = ['']
        call add(l:cont, "int main (int argc, char *argv[]) {")
        call add(l:cont, "    ")
        call add(l:cont, "}")
        call add(l:cont, "")
        call append(l:start_no, l:cont)
        call cursor(3, 4)
    endif
endfunction
autocmd BufRead,BufNewFile *.sc set filetype=scala

"file information
let s:file_info = 0
"nnoremap <F4> :call FileInfo() <cr>/ \* Description<cr>$
nnoremap <F4> :call FileInfo()<CR>/ \* Description<CR>$
function FileInfo()
    if search('\s\+\*\s\+Author\s\+:\s\+') > 0
        return
    endif
    let l:line_no = 0
    let l:edge = "//"
    if "\#!" == strpart(getline(1), 0, 2)
        let l:edge = "\# "
        let l:line_no = l:line_no + 1
    endif
    let l:info = []
    call add(l:info, "")
    call add(l:info, repeat(l:edge, 30))
    call add(l:info, l:edge)
    call add(l:info, l:edge . ' * Author       : lonli')
    call add(l:info, l:edge . ' * Email        : lonlicode@gmail.com')
    call add(l:info, l:edge . ' * File         : ' . expand("%:t"))
    call add(l:info, l:edge . ' * Create       : ' . strftime("%Y-%m-%d %H:%M"))
    call add(l:info, l:edge . ' * Modify       : ' . strftime("%Y-%m-%d %H:%M"))
    call add(l:info, l:edge)
    call add(l:info, l:edge . ' * Description  : ')
    call add(l:info, l:edge)
    call add(l:info, repeat(l:edge, 30))
    call add(l:info, "")
    call append(l:line_no, l:info)
    echohl WarningMsg | echo "file information added." | echohl warningMsg
endfunction

"update information
autocmd BufWritePre * call UpdateInfo()
function UpdateInfo()
    let l:winview = winsaveview()
    if (line('$') < 30)
        execute '%g/^.* \* Modify\s\+:/s@: .*$@\=strftime(": %Y-%m-%d %H:%M")@'
    else
        execute '1,30g/^.* \* Modify\s\+:/s@: .*$@\=strftime(": %Y-%m-%d %H:%M")@'
    endif
    call winrestview(l:winview)
endfunction

"lisence information
nnoremap <leader>l :call AddApacheLisence()<CR>gg
function AddApacheLisence()
    let l:b = '/*'
    let l:m = ' *'
    let l:e = ' */'
    let l:start_line = 0
    if match(getline(1), '\#!/') == 0
        let l:b = '#'
        let l:m = '# '
        let l:e = '#'
        let l:start_line = 1
    endif

    let l:copy_right = [""]
    call add(l:copy_right, l:b)
    call add(l:copy_right, l:m . ' Copyright (C) ' . strftime("%Y") . ' Togic Corporation. All rights reserved.')
    call add(l:copy_right, l:m . '')
    call add(l:copy_right, l:m . ' Licensed under the Apache License, Version 2.0 (the "License");')
    call add(l:copy_right, l:m . ' you may not use this file except in compliance with the License.')
    call add(l:copy_right, l:m . ' You may obtain a copy of the License at')
    call add(l:copy_right, l:m . '')
    call add(l:copy_right, l:m . ' http://www.apache.org/licenses/LICENSE-2.0')
    call add(l:copy_right, l:m . '')
    call add(l:copy_right, l:m . ' Unless required by applicable law or agreed to in writing, software')
    call add(l:copy_right, l:m . ' distributed under the License is distributed on an "AS IS" BASIS,')
    call add(l:copy_right, l:m . ' WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.')
    call add(l:copy_right, l:m . ' See the License for the specific language governing permissions and')
    call add(l:copy_right, l:m . ' limitations under the License.')
    call add(l:copy_right, l:e)
    call add(l:copy_right, "")

    call append(l:start_line, l:copy_right)
endfunction

"author information
nnoremap <leader>i :call AuthorInfo() <cr>/ \* Description<cr>$
function AuthorInfo()
    if search('\s\+\*\s\+Author\s\+:\s\+') > 0
        return
    endif
    let l:line_no = 0
    let l:edge = "//"
    if "\#!" == strpart(getline(1), 0, 2)
        let l:edge = "\# "
        let l:line_no = l:line_no + 1
    endif
    let l:info = []
    call add(l:info, "")
    call add(l:info, repeat(l:edge, 30))
    call add(l:info, l:edge)
    call add(l:info, l:edge . ' * Author       : lonli')
    call add(l:info, l:edge . ' * Email        : lonliness@gmail.com')
    call add(l:info, l:edge . ' * File         : ' . expand("%:t"))
    call add(l:info, l:edge . ' * Create       : ' . strftime("%Y-%m-%d %H:%M"))
    call add(l:info, l:edge . ' * Modify       : ' . strftime("%Y-%m-%d %H:%M"))
    call add(l:info, l:edge)
    call add(l:info, l:edge . ' * Description  : ')
    call add(l:info, l:edge)
    call add(l:info, repeat(l:edge, 30))
    call add(l:info, "")
    call append(l:line_no, l:info)
    echohl WarningMsg | echo "file information added." | echohl warningMsg
endfunction

"java import from rt.jar
nnoremap <leader>p :call RtImport() <cr>
function RtImport()
    let l:ft = expand("%:e")
    let l:prefix = "import "
    let l:key = expand("<cword>")
    if "py" == l:ft
        let l:result = l:key
    elseif "sc" == l:ft
        let l:result = split(system("grep '\\." . l:key . "$' ~/lib/class.txt"), '\n')
        let l:rl = len(l:result)
        echo l:rl
        if l:rl > 1
            let l:h = 7 + l:rl
            let l:wm = 0
            let l:pcmd = ""
            for s in l:result
                let l:pcmd = l:pcmd . s . " '' '' "
                let l:cl = strlen(s)
                if l:cl > l:wm
                    let l:wm = l:cl
                endif
            endfor
            let l:w = 12 + l:wm
            let l:cmd = "dialog --radiolist 'Select for " . l:key . "' " . l:h . " " . l:w . " " . l:rl . " " . l:pcmd ." --output-fd 1"
            let l:result = system(l:cmd)
        endif
    endif
    if "" != l:result
        let l:first_line = getline(1)
        let l:second_line = getline(2)
        let l:put_line = 1
        if "#!" == strpart(l:first_line, 0, 2) || "" == l:second_line
            let l:put_line = 2
        else
            let l:put_line = 0
        endif
        call append(l:put_line, l:prefix . l:result)
	let l:pos = l:put_line + 1
        echo l:prefix . " @ line " . l:pos
    endif
endfunction

nnoremap <leader>e :call WdExpand() <cr>
function WdExpand()
    let l:abbr = substitute(getline("."), '^\s*\(.\+\)\s*$', '\1', '')
    let l:result = substitute(getline("."), l:abbr, get(split(system("awk '/^" . expand("<cword>") . "/ {print $2;}' ~/lib/expand.txt"), '\n'), 0), '')
    call setline(line("."), l:result)
    echo "expand " . l:abbr
    startinsert!
endfunction

call plug#begin("~/.vim/plugged")
Plug 'pearofducks/ansible-vim'
Plug 'flazz/vim-colorschemes'
Plug 'derekwyatt/vim-scala'
call plug#end()

"if exists("$TMUX")
"    colorscheme motus
"else
"    colorscheme CandyPaper
"endif

if exists("$TMUX")
    colorscheme sea
else
    colorscheme apprentice
endif

