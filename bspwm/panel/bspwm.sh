#!/bin/sh

active_mon=`bspc query -D -d`
mons=`bspc query -D`
mons=`echo $mons`
echo $mons | sed 's/ /  /g' | sed 's/\(^\|$\)/ /g' | sed "s/ \($active_mon\) /%{R} \1 %{R}/g"
