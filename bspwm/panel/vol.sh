#!/bin/sh

__vol=`amixer sget Master`

if [[ `echo $__vol | grep "\[on"` ]]; then
  __v=`echo $__vol | egrep -o "[0-9]+%"`
else
  __v="MM"
fi
echo $__v
