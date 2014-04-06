#!/bin/sh

__bat=`acpi`
__perc=`echo $__bat | egrep -o "[0-9]+%" | head -c-2`
if [[ `echo $__bat | grep Full` ]]; then
  sym="="
elif [[ `echo $__bat | egrep "Unknown|Charging"` ]]; then
  sym="+"
elif [[ `echo $__bat | grep Discharging` ]]; then
  sym="-"
fi

echo $sym$__perc
