#!/bin/sh

killall -9 lemonbar

# FONT="-*-terminus-medium-r-normal--12-120-72-72-c-60-iso8859-1"
ICON_FONT="FontAwesome:pixelsize=13"
FONT="DejaVuSansMono:pixelsize=11:style=Book"
# OPACITY="fff"
BAR_HEIGHT=18
FG="bbbbbb"
BG="1c1c1c"

node ~/.config/bspwm/panel/panel.js | lemonbar -g 1920x$BAR_HEIGHT+0 -p -B "#$OPACITY$BG" -F "#$OPACITY$FG" -f "$FONT" -f "$ICON_FONT" | while read command; do eval "$command"; done
