#!/usr/bin/env bash

set -ue

packages=(
'https://github.com/Shougo/neocomplete.vim.git'
'https://github.com/godlygeek/tabular'
'https://github.com/tomtom/tcomment_vim'
'https://github.com/wellle/targets.vim'
'https://github.com/1995eaton/vim-better-javascript-completion'
'https://github.com/1995eaton/vim-better-javascript-highlighting'
'https://github.com/bling/vim-airline.git'
'https://github.com/junegunn/fzf.vim'
)

update_packages() {
  cd ~/.vim/bundle
  for e in ${packages[*]}; do
    base=$(echo "$e" | sed 's/.*\///' | sed 's/\.git$//')
    if [ ! -e "$base" ]; then
      echo -e "\033[36;1;31mCloning $base:\033[0;0m\n\n"
      git clone "$e"
    fi
  done
  cd - &> /dev/null
}

git_pull() {
  cd ~/.vim/bundle
  for repo in $(find . -maxdepth 2 -name '.git' -printf '%h\n'); do
    cd "$repo"
    echo -e "\033[36;1;31mUpgrading $(basename $(pwd)):\033[0;0m\n\n"
    git pull origin master
    cd -
  done
}

update_packages
git_pull
