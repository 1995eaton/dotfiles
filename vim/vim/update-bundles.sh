#!/bin/sh

bundle_dir="$HOME/.vim/bundle"
cd $bundle_dir

# 'https://github.com/1995eaton/vim-notes'
# 'http://git.code.sf.net/p/vim-latex/vim-latex'
# 'https://github.com/xolox/vim-misc'
# 'https://github.com/Shougo/neocomplete.vim.git'
packages=(
  'https://github.com/godlygeek/tabular'
  'https://github.com/tomtom/tcomment_vim'
  'https://github.com/bling/vim-airline.git'
  'https://github.com/mattn/emmet-vim'
  'https://github.com/scrooloose/syntastic'
  'git@github.com:1995eaton/vim-better-javascript-syntax.git'
)


if [[ $1 == '-p' ]]; then
  cd ..
  rm -rf autoload
  git clone 'https://github.com/tpope/vim-pathogen'
  mv vim-pathogen/autoload .
  rm -rf vim-pathogen
else
  for i in ${packages[*]}; do
    _dir=`echo $i | sed 's/^.*\///' | sed 's/\.git$//'`
    if [[ ! -e $_dir ]]; then
      echo -e "\033[36;1;31mCloning $_dir:\033[0;0m\n"
      git clone $i
    else
      cd $_dir && echo -e "\033[36;1;31mUpgrading $_dir:\033[0;0m\n"
      if [[ -d .git ]]; then
        git pull
      fi
      echo && cd $bundle_dir
    fi
  done
fi
