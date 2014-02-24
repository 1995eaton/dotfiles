#!/bin/sh

INTERVAL=$1

DATE() {

  _date=`date +%A\ \|\ %B\ %d,\ %Y\ \|\ %k:%M:%S\ %p`

  echo $_date > data/date.txt
  sleep $INTERVAL

  DATE

}

if [[ $INTERVAL != "" && -d data ]]; then
  DATE
fi
