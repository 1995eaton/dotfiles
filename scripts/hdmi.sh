#!/bin/sh

if [[ $1 == '1' ]]; then
  xrandr --output HDMI1 --mode 1920x1080 && xrandr --output eDP1 --off
elif [[ $1 == '0' ]]; then
  xrandr --output eDP1 --mode 1920x1080 && xrandr --output HDMI1 --off
fi
