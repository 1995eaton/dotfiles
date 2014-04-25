#!/bin/sh
acpi | awk '{if (/Unknown|Full|Charging/){print "",$4+0} else {a=100/6;if ($4 >= 100 - a) {printf ""} else if ($4 >= 100 - 2*a) {printf ""} else if ($4 >= 100 - 3*a) {printf ""} else if ($4 >= 100 - 4*a) {printf ""} else if ($4 >= 100 - 5*a) {printf ""} else {printf ""};printf " "$4+0;}}'
# __bat=`acpi`
# __perc=`echo $__bat | egrep -o "[0-9]+%" | head -c-2`
# if [[ `echo $__bat | grep Full` ]]; then
#   # sym="="
#   sym=""
# elif [[ `echo $__bat | egrep "Unknown|Charging"` ]]; then
#   # sym="+"
#   sym=""
# elif [[ `echo $__bat | grep Discharging` ]]; then
#   # sym="-"
#   sym=""
# fi
#
# echo $sym$__perc
