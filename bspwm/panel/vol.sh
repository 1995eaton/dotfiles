#!/bin/sh

__vol=`amixer sget Master`
if [[ `echo $__vol | grep "\[off"` ]]; then
  __v="MM"
else
  __v=`echo $__vol | egrep -o "[0-9]+%"`
fi
echo $__v
