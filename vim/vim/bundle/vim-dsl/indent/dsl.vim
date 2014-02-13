" Vim indent file
" Language: dsl
" Maintainer: Jake Eaton <1995eaton@gmail.com>
" Last Change: 2013-12-28

let b:did_indent = 1
set shiftwidth=3
set tabstop=3
" Use C-style indentation methods
setlocal cindent

" Disregard C-style semi-colon properties
setlocal cino=+0,j1,J1

let b:undo_indent = "setl cin<"
