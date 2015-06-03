" Vim color file
" Converted from my Textmate Code School theme using Coloration
" http://astonj.com

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Code School 3"

hi Cursor cterm=NONE ctermfg=234 ctermbg=248 gui=NONE
hi Visual cterm=NONE ctermfg=NONE ctermbg=239 gui=NONE
hi CursorLine cterm=NONE ctermfg=NONE ctermbg=237 gui=NONE
hi CursorColumn cterm=NONE ctermfg=NONE ctermbg=237 gui=NONE
hi ColorColumn cterm=NONE ctermfg=NONE ctermbg=237 gui=NONE
hi LineNr cterm=NONE ctermfg=102 ctermbg=236 gui=NONE
hi VertSplit cterm=NONE ctermfg=236 ctermbg=236 gui=NONE
hi MatchParen cterm=underline ctermfg=180 ctermbg=NONE gui=underline
hi StatusLine cterm=bold ctermfg=255 ctermbg=59 gui=bold
hi StatusLineNC cterm=NONE ctermfg=255 ctermbg=59 gui=NONE
hi Pmenu cterm=NONE ctermfg=153 ctermbg=NONE gui=NONE
hi PmenuSel cterm=NONE ctermfg=NONE ctermbg=239 gui=NONE
hi IncSearch cterm=NONE ctermfg=234 ctermbg=107 gui=NONE
hi Search cterm=underline ctermfg=NONE ctermbg=NONE gui=underline
hi Directory cterm=NONE ctermfg=32 ctermbg=NONE gui=NONE
hi Folded cterm=NONE ctermfg=247 ctermbg=234 gui=NONE

hi Normal cterm=NONE ctermfg=255 ctermbg=236 gui=NONE
hi Boolean cterm=NONE ctermfg=32 ctermbg=NONE gui=NONE
hi Character cterm=NONE ctermfg=32 ctermbg=NONE gui=NONE
hi Comment cterm=NONE ctermfg=247 ctermbg=NONE gui=italic
hi Conditional cterm=NONE ctermfg=180 ctermbg=NONE gui=NONE
hi Constant cterm=NONE ctermfg=32 ctermbg=NONE gui=NONE
hi Define cterm=NONE ctermfg=180 ctermbg=NONE gui=NONE
hi DiffAdd cterm=bold ctermfg=255 ctermbg=64 gui=bold
hi DiffDelete cterm=NONE ctermfg=1 ctermbg=NONE gui=NONE
hi DiffChange cterm=NONE ctermfg=255 ctermbg=24 gui=NONE
hi DiffText cterm=bold ctermfg=255 ctermbg=25 gui=bold
hi ErrorMsg cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE
hi WarningMsg cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE
hi Float cterm=NONE ctermfg=32 ctermbg=NONE gui=NONE
hi Function cterm=NONE ctermfg=153 ctermbg=NONE gui=NONE
hi Identifier cterm=NONE ctermfg=149 ctermbg=NONE gui=NONE
hi Keyword cterm=NONE ctermfg=180 ctermbg=NONE gui=NONE
hi Label cterm=NONE ctermfg=107 ctermbg=NONE gui=NONE
hi NonText cterm=NONE ctermfg=239 ctermbg=235 gui=NONE
hi Number cterm=NONE ctermfg=32 ctermbg=NONE gui=NONE
hi Operator cterm=NONE ctermfg=180 ctermbg=NONE gui=NONE
hi PreProc cterm=NONE ctermfg=180 ctermbg=NONE gui=NONE
hi Special cterm=NONE ctermfg=255 ctermbg=NONE gui=NONE
hi SpecialKey cterm=NONE ctermfg=239 ctermbg=236 gui=NONE
hi Statement cterm=NONE ctermfg=180 ctermbg=NONE gui=NONE
hi StorageClass cterm=NONE ctermfg=149 ctermbg=NONE gui=NONE
hi String cterm=NONE ctermfg=107 ctermbg=NONE gui=NONE
hi Tag cterm=NONE ctermfg=153 ctermbg=NONE gui=NONE
hi Title cterm=bold ctermfg=255 ctermbg=NONE gui=bold
hi Todo cterm=inverse,bold ctermfg=247 ctermbg=NONE gui=inverse,bold,italic
hi Type cterm=NONE ctermfg=153 ctermbg=NONE gui=NONE
hi Underlined cterm=underline ctermfg=NONE ctermbg=NONE gui=underline
hi rubyClass cterm=NONE ctermfg=180 ctermbg=NONE gui=NONE
hi rubyFunction cterm=NONE ctermfg=153 ctermbg=NONE gui=NONE
hi rubyInterpolationDelimiter cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE
hi rubySymbol cterm=NONE ctermfg=32 ctermbg=NONE gui=NONE
hi rubyConstant cterm=NONE ctermfg=146 ctermbg=NONE gui=NONE
hi rubyStringDelimiter cterm=NONE ctermfg=107 ctermbg=NONE gui=NONE
hi rubyBlockParameter cterm=NONE ctermfg=75 ctermbg=NONE gui=NONE
hi rubyInstanceVariable cterm=NONE ctermfg=75 ctermbg=NONE gui=NONE
hi rubyInclude cterm=NONE ctermfg=180 ctermbg=NONE gui=NONE
hi rubyGlobalVariable cterm=NONE ctermfg=75 ctermbg=NONE gui=NONE
hi rubyRegexp cterm=NONE ctermfg=179 ctermbg=NONE gui=NONE
hi rubyRegexpDelimiter cterm=NONE ctermfg=179 ctermbg=NONE gui=NONE
hi rubyEscape cterm=NONE ctermfg=32 ctermbg=NONE gui=NONE
hi rubyControl cterm=NONE ctermfg=180 ctermbg=NONE gui=NONE
hi rubyClassVariable cterm=NONE ctermfg=75 ctermbg=NONE gui=NONE
hi rubyOperator cterm=NONE ctermfg=180 ctermbg=NONE gui=NONE
hi rubyException cterm=NONE ctermfg=180 ctermbg=NONE gui=NONE
hi rubyPseudoVariable cterm=NONE ctermfg=75 ctermbg=NONE gui=NONE
hi rubyRailsUserClass cterm=NONE ctermfg=146 ctermbg=NONE gui=NONE
hi rubyRailsARAssociationMethod cterm=NONE ctermfg=186 ctermbg=NONE gui=NONE
hi rubyRailsARMethod cterm=NONE ctermfg=186 ctermbg=NONE gui=NONE
hi rubyRailsRenderMethod cterm=NONE ctermfg=186 ctermbg=NONE gui=NONE
hi rubyRailsMethod cterm=NONE ctermfg=186 ctermbg=NONE gui=NONE
hi erubyDelimiter cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE
hi erubyComment cterm=NONE ctermfg=247 ctermbg=NONE gui=italic
hi erubyRailsMethod cterm=NONE ctermfg=186 ctermbg=NONE gui=NONE
hi htmlTag cterm=NONE ctermfg=111 ctermbg=NONE gui=NONE
hi htmlEndTag cterm=NONE ctermfg=111 ctermbg=NONE gui=NONE
hi htmlTagName cterm=NONE ctermfg=111 ctermbg=NONE gui=NONE
hi htmlArg cterm=NONE ctermfg=111 ctermbg=NONE gui=NONE
hi htmlSpecialChar cterm=NONE ctermfg=32 ctermbg=NONE gui=NONE
hi javaScriptFunction cterm=NONE ctermfg=149 ctermbg=NONE gui=NONE
hi javaScriptRailsFunction cterm=NONE ctermfg=186 ctermbg=NONE gui=NONE
hi javaScriptBraces cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE
hi yamlKey cterm=NONE ctermfg=153 ctermbg=NONE gui=NONE
hi yamlAnchor cterm=NONE ctermfg=75 ctermbg=NONE gui=NONE
hi yamlAlias cterm=NONE ctermfg=75 ctermbg=NONE gui=NONE
hi yamlDocumentHeader cterm=NONE ctermfg=107 ctermbg=NONE gui=NONE
hi cssURL cterm=NONE ctermfg=75 ctermbg=NONE gui=NONE
hi cssFunctionName cterm=NONE ctermfg=186 ctermbg=NONE gui=NONE
hi cssColor cterm=NONE ctermfg=32 ctermbg=NONE gui=NONE
hi cssPseudoClassId cterm=NONE ctermfg=153 ctermbg=NONE gui=NONE
hi cssClassName cterm=NONE ctermfg=153 ctermbg=NONE gui=NONE
hi cssValueLength cterm=NONE ctermfg=32 ctermbg=NONE gui=NONE
hi cssCommonAttr cterm=NONE ctermfg=151 ctermbg=NONE gui=NONE
hi cssBraces cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE

