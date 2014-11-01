#!/usr/bin/env zsh

cd /usr/share/themes/Numix &&
sudo grep -ril '#2d2d2d' | xargs sed -i 's/2d2d2d/1c1c1c/gi' &&
sudo grep -ril '#d64937' | xargs sed -i 's/d64937/ff005f/gi'
