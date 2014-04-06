#!/bin/sh
active_mon=`bspc query -D -d`
mons=`bspc query -D | tr "\n" " " | sed 's/ \?\([0-9]\)\( \)\?/%{A:bspc desktop -f \1:} \1 %{A}/g'`
echo $mons | sed 's/\(^\|$\)//g' | sed "s/ \($active_mon\) /%{R} \1 %{R}/g"
