#!/bin/bash

compton &
xmodmap /home/jake/.macros &
nitrogen --restore &
conky | while read -r; do xsetroot -name "$REPLY"; done &
xset r rate 400 35 &
xset m 1/2 &
