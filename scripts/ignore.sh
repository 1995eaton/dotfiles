#!/bin/sh

if [[ -f ~/.gitignore-global ]]; then
  git config --global core.excludesfile ~/.gitignore_global
  echo "Global .gitignore added (~/.gitignore_global)"
else
  echo "Error: ~/.gitignore not found"
fi
