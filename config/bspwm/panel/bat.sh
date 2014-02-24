#!/bin/sh

INTERVAL=$1

BAT() {

  _info=`acpi`

  _bat_perc=`echo $_info | grep -o "[0-9]\+%"`
  _bat_status=`echo $_info | grep -o "Charging\|Discharging\|Full\|Unknown" | sed 's/Unknown/Charging/'`
  _bat_remain=`echo $_info | grep -o "[0-9]\+:[0-9]\+:[0-9]\+" | sed 's/^0\([0-9]\)/\1/'`

  echo $_bat_perc > data/bat.txt

  sleep $INTERVAL

  BAT

}

if [[ $INTERVAL != "" && -d ./data ]]; then
  BAT
fi
