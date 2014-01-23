" Vim syntax file
" Language:	DSSSL
" Maintainer:	Jake Eaton <1995eaton@gmail.com>
" Last Change:	2013-12-28
" Filenames:	*.dsl

syn keyword dslStructure External DefinitionBlock OperationRegion
syn keyword dslCommands Scope Alias Return
syn keyword dslConditional If Else
syn keyword dslIdentifier Name MethodObj Device Offset
syn keyword dslStatement Method
syn keyword dslType Package Field
syn match dslComment "\/\*\_.\{-}\*\/"
syn match dslComment "\/\/.*"
syn match   dslNumber	"\<0[oO]\=\o\+[Ll]\=\>"
syn match   dslNumber	"\<0[xX]\x\+[Ll]\=\>"
syn match   dslNumber	"\<0[bB][01]\+[Ll]\=\>"
syn match   dslNumber	"\<\%([1-9]\d*\|0\)[Ll]\=\>"
syn match   dslNumber	"\<\d\+[jJ]\>"
syn match   dslNumber	"\<\d\+[eE][+-]\=\d\+[jJ]\=\>"
syn match   dslNumber "\<\d\+\.\%([eE][+-]\=\d\+\)\=[jJ]\=\%(\W\|$\)\@="
syn match   dslNumber "\%(^\|\W\)\@<=\d*\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>"
syn match dslIdentifier "Arg\(\d\)\+"
syn match dslNumber /\<One\>\|\<Zero\>/

syn region  dslString start=+[uU]\=\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1" contains=dslEscape,@Spell

hi link dslStructure Structure
hi link dslComment Comment
hi link dslNumber Constant
hi link dslString String
hi link dslIdentifier Identifier
hi link dslType Type
hi link dslCommands Keyword
hi link dslStatement Statement
hi link dslConditional Conditional

let b:current_syntax = "dsl"
