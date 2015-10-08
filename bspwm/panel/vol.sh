#!/bin/sh

VOL="$(amixer sget Master | tail -1 | grep '\[on\]' | grep -oE '[0-9]+%')"
[[ $VOL ]] || { VOL="MM"; }
echo $VOL
