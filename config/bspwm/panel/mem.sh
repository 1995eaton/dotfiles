#!/bin/zsh
__mem=`cat /proc/meminfo`
echo $(echo 'scale=1;' `echo $__mem | grep Active: | egrep -o "[0-9]+"` \/ 1048576 | bc)\/$(echo 'scale=1;' `echo $__mem | grep MemTotal | egrep -o "[0-9]+"` \/ 1048576 | bc)
