#!/usr/bin/bash

mons=""
active_mon=""

get_active_mon() {
  active_mon=`bspc query -T -d | head -n 2 | tail -n 1`
  active_mon=`echo $active_mon | sed 's/ .*//g'`
}

get_mons() {
  mons=`bspc query -D`
}

format_output() {
  get_active_mon
  get_mons
  echo $mons | sed "s/\($active_mon\)/\\\f2\1\\\f\\\/"
}

format_output
