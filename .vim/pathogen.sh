#!/bin/bash

if [[ ! -d "autoload" ]]; then
	mkdir autoload
fi
if [[ ! -d "bundle" ]]; then
	mkdir bundle
fi

curl -Sso autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
