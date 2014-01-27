execute pathogen#infect()

"Color schemes
   set t_Co=256
   colorscheme jellybeans
   "Lightline
      set laststatus=2
      let g:lightline = { 'colorscheme': 'jellybeans' }

"File settings
   filetype plugin indent on
   set fileformats=unix,dos,mac

"Syntax hightlighting
   syntax on
   map <silent> fh :nohl<cr>

"Line numbering (dynamic + relative)
   set relativenumber
   set number
   nnoremap <silent> <C-n> :set relativenumber!<cr>

"Cursor movement
   "set scrolloff=1000 "Keep cursor centered
   nnoremap 0 g^
   nnoremap $ g$
   map J <C-d>
   map K <C-u>
   inoremap fj <Esc>
   vnoremap fj <Esc>
   imap fh zz "Center screen at cursor position

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

"Copy/Paste across terminals
   vnoremap Y "+y
   nmap P "+p
   vmap P "+p

"Reload vimrc
   nmap <silent> <leader>r :so ~/.vimrc<cr>

"Vim comments
   nmap fd <C-c>k
   vmap fd <C-c>
   map ff <C-x>

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

"Miscellaneous
   let mapleader=","
   set noerrorbells visualbell t_vb=
   set lazyredraw
