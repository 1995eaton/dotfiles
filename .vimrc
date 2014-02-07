execute pathogen#infect()
"Color schemes
  set t_Co=256
  colorscheme molokai
  set background=dark
"Lightline
  set laststatus=2
  let g:lightline = { 'colorscheme': 'jellybeans' }

"File settings
  filetype plugin indent on
  set fileformats=unix,dos,mac

"Unite
  let g:unite_force_overwrite_statusline = 0
  let g:unite_winheight = 15

  call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
        \ 'ignore_pattern', join([
        \ '\.git/',
        \ ], '\|'))

  call unite#filters#matcher_default#use(['matcher_fuzzy'])
  call unite#filters#sorter_default#use(['sorter_rank'])

  nnoremap <C-p> :Unite file_rec<cr>

  autocmd FileType unite call s:unite_settings()

  function! s:unite_settings()
    let b:SuperTabDisabled=1
    map <silent><buffer><expr> h unite#do_action('split')
    map <silent><buffer><expr> v unite#do_action('vsplit')
    map <silent><buffer><expr> t unite#do_action('tabopen')

    nmap <buffer> <ESC> <Plug>(unite_exit)
  endfunction

"Syntax hightlighting
  syntax on
  "map <silent> fh :nohl<cr>
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
  "inoremap fj <Esc>
  "vnoremap fj <Esc>

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

"Windows
  "map fw <C-w><C-w>
  "map <C-h> <C-w>h
  "map <C-l> <C-w>l
  "map <C-k> <C-w>k
  "map <C-j> <C-w>j

"Emmet
  let g:user_emmet_leader_key='<C-e>'

"Miscellaneous
  set noerrorbells visualbell t_vb=
  nnoremap <buffer> <C-b> :exec '!python' shellescape(@%, 1)<cr>
  set lazyredraw
  fun! TabComplete()
    if &ft !~ "note"
      imap <Tab> <C-n>
      imap <S-Tab> <C-p>
    endif
  endfun
  autocmd BufNewFile,BufRead * call TabComplete()
