" Vim color file
"
" Author: Anthony Carapetis <anthony.carapetis@gmail.com>
"
" Note: Based on github's syntax highlighting theme
"       Used Brian Mock's darkspectrum as a starting point/template
"       Thanks to Ryan Heath for an easy list of some of the colours:
"       http://rpheath.com/posts/356-github-theme-for-syntax-gem


set background=light
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    if exists("syntax_on")
	syntax reset
    endif
endif
let g:colors_name="github"

hi Normal       ctermfg=16 ctermbg=231

" {{{ Cursor
hi Cursor		ctermbg=238 ctermfg=231
hi CursorLine	ctermbg=188
hi CursorColumn	ctermbg=254
" }}}

" {{{ Diff
hi DiffAdd         ctermfg=22 ctermbg=194 cterm=none
hi DiffChange                    ctermbg=255 cterm=none
hi DiffText        ctermfg=17 ctermbg=189 cterm=none
hi DiffDelete      ctermfg=252 ctermbg=224 cterm=none
" }}}

" {{{ Folding / Line Numbering / Status Lines
hi Folded		ctermbg=255 ctermfg=244 cterm=bold
hi vimFold		ctermbg=255 ctermfg=244 cterm=bold
hi FoldColumn	ctermbg=255 ctermfg=244 cterm=bold

hi LineNr		ctermfg=246 ctermbg=255 cterm=bold
hi NonText		ctermfg=244 ctermbg=255
hi Folded		ctermfg=244 ctermbg=255 cterm=bold
hi FoldeColumn  ctermfg=244 ctermbg=255 cterm=bold

hi VertSplit	ctermbg=250 ctermfg=250 cterm=none
hi StatusLine   ctermbg=250 ctermfg=238 cterm=bold
hi StatusLineNC ctermbg=188 ctermfg=238 cterm=bold
" }}}

" {{{ Misc
hi ModeMsg		ctermfg=88
hi MoreMsg		ctermfg=88

hi Title		ctermfg=203
hi WarningMsg	ctermfg=203
hi SpecialKey   ctermfg=30 cterm=bold

hi MatchParen	ctermbg=189 ctermfg=16
hi Underlined	ctermfg=16 cterm=underline
hi Directory	ctermfg=88
" }}}

" {{{ Search, Visual, etc
hi Visual		ctermfg=231 ctermbg=25 cterm=none
hi VisualNOS    ctermfg=231 ctermbg=25 cterm=none
hi IncSearch	ctermbg=189 ctermfg=16 cterm=bold
hi Search		ctermbg=189 ctermfg=16 cterm=bold
" }}}

" {{{ Syntax groups
hi Ignore		ctermfg=244
hi Identifier	ctermfg=31
hi PreProc		ctermfg=247 cterm=bold
hi Comment		ctermfg=246
hi Constant		ctermfg=30 cterm=none
hi String		ctermfg=197
hi Function		ctermfg=88 cterm=bold
hi Statement	ctermfg=16 cterm=bold
hi Type			ctermfg=60 cterm=bold
hi Number		ctermfg=30
hi Todo			ctermfg=231 ctermbg=88 cterm=bold
hi Special		ctermfg=28 cterm=bold
hi rubySymbol   ctermfg=89
hi Error        ctermbg=231 ctermfg=196 
hi Todo         ctermbg=231 ctermfg=196 cterm=underline
hi Label        ctermfg=16 cterm=bold
hi StorageClass ctermfg=16 cterm=bold
hi Structure    ctermfg=16 cterm=bold
hi TypeDef      ctermfg=16 cterm=bold
" }}}

" {{{ Completion menus
hi WildMenu     ctermfg=75 ctermbg=24 cterm=none

hi Pmenu        ctermbg=244 ctermfg=231 cterm=bold
hi PmenuSel     ctermbg=189 ctermfg=16 cterm=bold
hi PmenuSbar    ctermbg=16 ctermfg=238
hi PmenuThumb   ctermbg=248 ctermfg=248
" }}}

" {{{ Spelling
" }}}

" {{{ Aliases
" }}}

" {{{ Tabs (non-cterm0
hi TabLine		ctermfg=238 ctermbg=253 cterm=none
hi TabLineFill	ctermfg=238 ctermbg=253 cterm=none
hi TabLineSel	ctermfg=238 cterm=bold
" }}}
"
" vim: sw=4 ts=4 foldmethod=marker

