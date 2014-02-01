#!/bin/sh

bundle_dir="$HOME/.vim/bundle"
cd $bundle_dir

packages=(
   'https://github.com/scrooloose/nerdcommenter'
   'https://github.com/itchyny/lightline.vim'
   'https://github.com/scrooloose/nerdtree'
   'https://github.com/kchmck/vim-coffee-script'
   'https://github.com/1995eaton/vim-notes'
   'https://github.com/xolox/vim-misc'
   'https://github.com/dag/vim2hs'
   'https://github.com/Lokaltog/vim-easymotion'
)

for i in ${packages[*]}; do
   _dir=`echo $i | sed 's/https.*\///g'`
   if [[ ! -d $_dir ]]; then
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
