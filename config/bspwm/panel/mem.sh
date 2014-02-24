#!/bin/sh

INTERVAL=$1

MEM() {
  temp_mem=(`free -gh | grep Mem | egrep -o "[0-9.]+G"`)
  _mem="`echo ${temp_mem[1]} | sed 's/G//'`/${temp_mem[0]}"
  echo $_mem > data/mem.txt
  sleep $INTERVAL
  MEM
}

if [[ $INTERVAL != "" && -d data ]]; then
  MEM
fi
