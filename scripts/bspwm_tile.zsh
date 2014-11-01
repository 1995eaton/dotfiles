#!/usr/bin/env zsh

WINDOWS=($(bspc query -W -d))

for i in $WINDOWS; do
  bspc window $i -t floating=off -t fullscreen=off
done
