#!/bin/sh

__vol=`amixer sget Master`
if [[ `echo $__vol | grep "\[off"` ]]; then
  echo "MM"
else
  echo $__vol | egrep -o "[0-9]+%"
fi
