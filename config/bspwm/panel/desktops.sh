#!/bin/bash

INTERVAL=$1

mons=""
active_mon=""

get_active_mon() {
  active_mon=`bspc query -T -d | head -n 2 | tail -n 1`
  active_mon=`echo $active_mon | sed 's/ .*//g'`
}

get_mons() {
  mons=`bspc query -D`
  mons=`echo $mons`
}

format_output() {
  get_active_mon
  get_mons
  echo $mons | sed 's/ /  /g' | sed 's/\(^\|$\)/ /g' | sed "s/ \($active_mon\) /\\\f9\\\b1 \1 \\\b\\\ \\\f/g" > data/desktops.txt

  sleep $INTERVAL

  format_output
}

if [[ $INTERVAL != "" && -d data ]]; then
  format_output
fi
