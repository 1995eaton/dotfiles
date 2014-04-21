#!/bin/sh
killall -9 conky bar
# FONT="-*-terminus-medium-r-normal--12-120-72-72-c-60-iso8859-1"
# FONT="-*-stlarch-medium-r-normal--10-100-75-75-c-80-iso10646-1"
# FONT="-*-terminusmod*-medium-r-normal--12-120-72-72-c-60-iso8859-1"
FONT="-*-ticon-medium-r-normal--12-120-72-72-c-60-iso8859-1"
conky -c ~/.config/bspwm/panel/conkyrc | bar -g 1920x15+0 -p -B "#fff1b1d1e" -F "#fffbbbbbb" -f $FONT | sh
# conky -c ~/.config/bspwm/panel/conkyrc | bar -g 1920x15+0 -p -B "#fff002b36" -F "#fff839496" -f "-*-terminus-medium-r-normal--12-120-72-72-c-60-iso8859-1" | sh
