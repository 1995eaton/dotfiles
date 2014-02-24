#!/bin/sh

#INTERVALS
_desktops=3
_cpu=5
_bat=30
_mem=10
_vol=3
_date=1

if [[ $1 == '-s' ]]; then
  ./desktops.sh $_desktops &
  ./cpu.sh $_cpu &
  ./bat.sh $_bat &
  ./date.sh $_date &
  ./mem.sh $_mem &
  ./vol.sh $_vol &
elif [[ $1 == '-x' ]]; then
  killall -9 desktops.sh
  killall -9 cpu.sh
  killall -9 bat.sh
  killall -9 date.sh
  killall -9 mem.sh
  killall -9 vol.sh
  killall bar
  rm data/*.txt
fi
