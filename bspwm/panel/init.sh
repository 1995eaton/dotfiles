#!/bin/sh

killall -9 conky bar

FONT="-*-terminus-symbols-medium-r-normal--12-120-72-72-c-60-iso8859-1"
OPACITY="fd0"
FG="bbbbbb"
# BG="1b1d1e"
BG="1c1c1c"
conky -c ~/.config/bspwm/panel/conkyrc | bar -g 1920x12+0 -p -B "#$OPACITY$BG" -F "#$OPACITY$FG" -f $FONT
