#!/bin/sh

CURRENT=$(bspc query -D -d)
ALL=$(bspc query -D | tr "\n" " " | head -c-1)

echo " $ALL " | sed "s/[^$CURRENT ]//g" | sed "s/$CURRENT//"
