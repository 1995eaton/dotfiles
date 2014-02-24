#!/bin/sh

UPDATE_INTERVAL=1

if [[ ! -d data ]]; then
  echo "Error: data folder could not be found"
  exit
fi

if [[ ! -f dispatch.sh ]]; then
  echo "Error: dispatch script could not be found"
  exit
fi

./dispatch.sh -s

update_status() {

  if [[ -f data/desktops.txt ]]; then
    echo -n "\\l\\u1`cat data/desktops.txt`\\u "
  fi

  if [[ -f data/date.txt ]]; then
    echo -n "\\c`cat data/date.txt`"
  fi

  if [[ -f data/vol.txt ]]; then
    echo -n "\\rVOL[`cat data/vol.txt`] | "
  fi

  if [[ -f data/bat.txt ]]; then
    echo -n "BAT[`cat data/bat.txt`] | "
  fi

  if [[ -f data/cpu.txt ]]; then
    echo -n "CPU[`cat data/cpu.txt`] | "
  fi

  if [[ -f data/mem.txt ]]; then
    echo -e "RAM[`cat data/mem.txt`] "
  fi

  sleep $UPDATE_INTERVAL

  update_status

}

update_status
