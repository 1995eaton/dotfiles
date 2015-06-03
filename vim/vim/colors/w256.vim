" Vim color file
"
" Author: Tomas Restrepo <tomas@winterdom.com>
" https://github.com/tomasr/molokai
"
" Note: Based on the Monokai theme for TextMate
" by Wimer Hazenberg and its darker variant
" by Hamish Stuart Macpherson
"


if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="molokai"

if exists("g:molokai_original")
    let s:molokai_original = g:molokai_original
else
    let s:molokai_original = 0
endif


hi Boolean         ctermfg=141
hi Character       ctermfg=185
hi Number          ctermfg=141
hi String          ctermfg=185
hi Conditional     ctermfg=161               cterm=bold
hi Constant        ctermfg=141               cterm=bold
hi Cursor          ctermfg=16 ctermbg=231
hi iCursor         ctermfg=16 ctermbg=231
hi Debug           ctermfg=181               cterm=bold
hi Define          ctermfg=81
hi Delimiter       ctermfg=246
hi DiffAdd                       ctermbg=236
hi DiffChange      ctermfg=244 ctermbg=238
hi DiffDelete      ctermfg=125 ctermbg=232
hi DiffText                      ctermbg=238 cterm=bold,bold

hi Directory       ctermfg=148               cterm=bold
hi Error           ctermfg=185 ctermbg=232
hi ErrorMsg        ctermfg=161 ctermbg=235 cterm=bold
hi Exception       ctermfg=148               cterm=bold
hi Float           ctermfg=141
hi FoldColumn      ctermfg=239 ctermbg=16
hi Folded          ctermfg=239 ctermbg=16
hi Function        ctermfg=148
hi Identifier      ctermfg=208
hi Ignore          ctermfg=244 
hi IncSearch       ctermfg=144 ctermbg=16

hi Keyword         ctermfg=161               cterm=bold
hi Label           ctermfg=185               cterm=none
hi Macro           ctermfg=144               cterm=bold
hi SpecialKey      ctermfg=81               cterm=bold

hi MatchParen      ctermfg=16 ctermbg=208 cterm=bold
hi ModeMsg         ctermfg=185
hi MoreMsg         ctermfg=185
hi Operator        ctermfg=161

" complete menu
hi Pmenu           ctermfg=81 ctermbg=16
hi PmenuSel                      ctermbg=244
hi PmenuSbar                     ctermbg=232
hi PmenuThumb      ctermfg=81

hi PreCondit       ctermfg=148               cterm=bold
hi PreProc         ctermfg=148
hi Question        ctermfg=81
hi Repeat          ctermfg=161               cterm=bold
hi Search          ctermfg=16 ctermbg=222
" marks
hi SignColumn      ctermfg=148 ctermbg=235
hi SpecialChar     ctermfg=161               cterm=bold
hi SpecialComment  ctermfg=245               cterm=bold
hi Special         ctermfg=81       cterm=bold
if has("spell")
endif
hi Statement       ctermfg=161               cterm=bold
hi StatusLine      ctermfg=239 
hi StatusLineNC    ctermfg=244 ctermbg=232
hi StorageClass    ctermfg=208               cterm=bold
hi Structure       ctermfg=81
hi Tag             ctermfg=161               cterm=bold
hi Title           ctermfg=203
hi Todo            ctermfg=231       cterm=bold

hi Typedef         ctermfg=81
hi Type            ctermfg=81               cterm=none
hi Underlined      ctermfg=244               cterm=underline

hi VertSplit       ctermfg=244 ctermbg=232 cterm=bold
hi VisualNOS                     ctermbg=237
hi Visual                        ctermbg=237
hi WarningMsg      ctermfg=231 ctermbg=236 cterm=bold
hi WildMenu        ctermfg=81 ctermbg=16

hi TabLineFill     ctermfg=234 ctermbg=234
hi TabLine         ctermbg=234 ctermfg=244 cterm=none

if s:molokai_original == 1
   hi Normal          ctermfg=231 ctermbg=235
   hi Comment         ctermfg=243
   hi CursorLine                    ctermbg=237
   hi CursorLineNr    ctermfg=208               cterm=none
   hi CursorColumn                  ctermbg=237
   hi ColorColumn                   ctermbg=237
   hi LineNr          ctermfg=250 ctermbg=237
   hi NonText         ctermfg=243
   hi SpecialKey      ctermfg=243
else
   hi Normal          ctermfg=231 ctermbg=234
   hi Comment         ctermfg=245
   hi CursorLine                    ctermbg=236
   hi CursorLineNr    ctermfg=208               cterm=none
   hi CursorColumn                  ctermbg=236
   hi ColorColumn                   ctermbg=235
   hi LineNr          ctermfg=239 ctermbg=235
   hi NonText         ctermfg=239
   hi SpecialKey      ctermfg=239
end

"
" Support for 256-color terminal
"
if &t_Co > 255
   if s:molokai_original == 1
   else
   endif





   " complete menu


   " marks column
   if has("spell")
   endif





   if exists("g:rehash256") && g:rehash256 == 1






   endif
end

" Must be at the end, because of  bug.
" https://groups.google.com/forum/16!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark

