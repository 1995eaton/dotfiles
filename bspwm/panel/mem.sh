#!/bin/sh

__mem=`cat -E /proc/meminfo`
__m=$(echo 'scale=1;' `echo $__mem | tr "$" "\n" | grep Active: | egrep -o "[0-9]+"` \/ 1048576 | bc)\/$(echo 'scale=1;' `echo $__mem | tr "$" "\n" | grep MemTotal | egrep -o "[0-9]+"` \/ 1048576 | bc)
echo $__m
