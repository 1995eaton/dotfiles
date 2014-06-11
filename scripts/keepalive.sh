#!/bin/sh

if [ $1 ]; then
  DEV=$1
else
  DEV='wlan0'
fi
if [ $2 ]; then
  INTERVAL=$2
else
  INTERVAL=30
fi
HOST=`ip addr show dev $DEV | grep -Eo 'inet ([0-9]+\.?)+' | cut -c6-`

inc=0
function kill_prgm() {
  echo -e "\n$inc packets transmitted"
  exit 0
}

trap kill_prgm INT

if [[ $HOST ]]; then
  while true; do
    inc=$(($inc + 1))
    ping -c1 $HOST &> /dev/null
    sleep $INTERVAL
  done
fi
