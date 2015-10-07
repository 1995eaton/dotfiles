#!/bin/sh

killall -9 conky lemonbar

FONT="-*-terminus-symbols-medium-r-normal--12-120-72-72-c-60-iso8859-1"
# OPACITY="ff3"
OPACITY="fff"
FG="bbbbbb"
# BG="1b1d1e"
BG="1c1c1c"
conky -c ~/.config/bspwm/panel/conkyrc | lemonbar -g 1920x15+0 -p -B "#$OPACITY$BG" -F "#$OPACITY$FG" -f $FONT
