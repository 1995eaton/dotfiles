execute pathogen#infect()
"Color schemes
  set t_Co=256
  colorscheme molokai
  set background=dark
"Lightline
  set laststatus=2
  let g:lightline = { 'colorscheme': 'wombat' }

"File settings
  filetype plugin indent on
  set fileformats=unix,dos,mac

"Syntax hightlighting
  syntax on
  map <silent> <C-h> :nohl<cr>

"Line numbering (dynamic + relative)
  set number

"Cursor movement
  set mouse=a
  map 0 ^
  nnoremap j gj
  nnoremap k gk
  map J jzz
  map K kzz
  map L zz

"Disable line breaks unless the <Enter> key is hit
  set wrap
  set linebreak
  set nolist
  set textwidth=0
  set wrapmargin=0

"Normal backspace behavior (non-Vi)
  set backspace=2

"Tab settings
  set smarttab
  set tabstop=2
  set shiftwidth=2
  set expandtab

"Searching
  set incsearch 
  set hlsearch
  set ignorecase
  set smartcase
  set magic

"Copy/Paste to/from X buffer
  vnoremap Y "+y
  nmap P "+p
  vmap P "+p

"Reload vimrc
  nmap <silent> <leader>r :so ~/.vimrc<cr>

"Vim comments
  nmap fd <leader>cb
  vmap fd <leader>cb
  nmap ff <leader>cu
  vmap ff <leader>cu

"Bracket highlighting
  set showmatch 
  set matchtime=2

"Disable file backups + swapfile creation
  set noswapfile
  set nobackup
  set nowb

"Command mode settings
  set wildmenu
  set wildmode=list:longest
  set shellslash
  set history=100

"Vim notes
  let g:notes_directories=['~/notes']   

"EasyMotion
  map <C-j> <leader><leader>w
  map <C-k> <leader><leader>gE

"Emmet
  let g:user_emmet_leader_key='<C-e>'

"Miscellaneous
  let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
  vnoremap . :normal .<CR>
  set noerrorbells visualbell t_vb=
  nnoremap <buffer> <C-b> :w<cr>:exec '!clear'<cr>:exec '!python' shellescape(@%, 1)<cr>
  set lazyredraw
  "fun! TabComplete()
  "  if &ft !~ "note"
  "    imap <Tab> <C-n>
  "    imap <S-Tab> <C-p>
  "  endif
  "endfun
  "autocmd BufNewFile,BufRead * call TabComplete()
