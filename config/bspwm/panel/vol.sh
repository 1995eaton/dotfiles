#!/bin/sh

INTERVAL=$1

VOL() {
  if [[ `amixer sget Master | grep -o "\[off\]"` > /dev/null ]]; then
    echo "mm" > data/vol.txt
  else
    echo `amixer sget Master | grep -o "[0-9]\+%"` > data/vol.txt
  fi
  sleep $INTERVAL
  VOL
}

if [[ $INTERVAL != "" && -d data ]]; then
  VOL
fi
