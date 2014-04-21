#!/bin/sh
acpi | awk '{if (/Unknown|Full|Charging/){print "",$4} else {a=100/6;if ($4 >= 100 - a) {print ""} else if ($4 >= 100 - 2*a) {print ""} else if ($4 >= 100 - 3*a) {print ""} else if ($4 >= 100 - 4*a) {print ""} else if ($4 >= 100 - 5*a) {print ""} else {print ""}}}'
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
