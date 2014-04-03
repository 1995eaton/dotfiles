#!/bin/sh

__bat=`acpi`
__perc=`echo $__bat | egrep -o "[0-9]+%" | head -c-2`
if [[ `echo $__bat | grep Full` ]]; then
  echo \=$__perc
elif [[ `echo $__bat | egrep "Unknown|Charging"` ]]; then
  echo +$__perc
elif [[ `echo $__bat | grep Discharging` ]]; then
  echo -$__perc
fi
