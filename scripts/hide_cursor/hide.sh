#!/bin/sh

cd `dirname $0`
input=$(xinput --list | grep -E "Unify|Touch" | grep -Eo "id=[0-9]+" | cut -c4- | tr "\n" " " | head -c-1)

on() {
  cpos=$(cat mloc)
  rm mloc
  xsetroot -cursor_name left_ptr
  for i in $input; do
    xinput --enable $i;
  done
  xdotool mousemove 0 0
  xdotool mousemove_relative $cpos
}

off() {
  mloc=`xdotool getmouselocation`
  x=`echo $mloc | egrep -o "x:([0-9])+" | cut -c3-`
  y=`echo $mloc | egrep -o "y:([0-9])+" | cut -c3-`
  xsetroot -cursor empty empty
  xdotool mousemove 960 1080
  for i in $input; do
    echo $i
    xinput --disable $i;
  done
  echo $x $y > mloc
}

if [[ ! -f mloc ]]; then
  off
else
  on
fi

cd -
