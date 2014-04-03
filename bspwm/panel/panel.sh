#!/bin/sh

# Timeouts

tmp_dir=/home/jake/.config/bspwm/panel/tmp

_bat=20; _thermal=5; _disk=200
_mem=20; _vol=10;    _bspwm=0.5
_date=1; _cpu=1

# Main output
      # $tmp_dir/cpu.out     \
OUTPUT() {
  cat $tmp_dir/bspwm.out   \
      $tmp_dir/date.out    \
      $tmp_dir/bat.out     \
      $tmp_dir/vol.out     \
      $tmp_dir/thermal.out \
      $tmp_dir/disk.out    \
      $tmp_dir/mem.out     \
  | tr "\n" " "
  echo
  sleep 1
  OUTPUT
}

# Scripts
BAT() {
  __bat=`acpi`
  __perc=`echo $__bat | egrep -o "[0-9]+%" | head -c-2`
  if [[ `echo $__bat | grep Full` ]]; then
    sym=`echo "B[="$__perc"] |"`
  elif [[ `echo $__bat | egrep "Unknown|Charging"` ]]; then
    sym=`echo "B[+"$__perc"] |"`
  elif [[ `echo $__bat | grep Discharging` ]]; then
    sym=`echo "B[-"$__perc"] |"`
  fi
  echo $sym > $tmp_dir/bat.out
  sleep $_bat
  BAT
}

# CPU usage
# _cores=('0')
# __idle_old=(0 0 0 0 0 0 0 0)
# __total_old=(0 0 0 0 0 0 0 0)
# CPU() {
#   __cpu=`cat -E /proc/stat`
#   __all=""
#   for i in ${_cores[*]}; do
#     __info=`echo $__cpu | tr "$" "\n" | egrep "cpu " | sed 's/.*cpu\([^ ]\+\) //g'`
#     __total[$i]=`echo $__info | sed 's/ /+/g' | bc`
#     __info=($__info)
#     __idle=${__info[3]}
#     __diff_total=`echo ${__total[$i]} - ${__total_old[$i]} | bc`
#     __diff_idle=`echo $__idle - ${__idle_old[$i]} | bc`
#     if [[ $__diff_idle == "0" || $__diff_total == "0" ]]; then
#       cpu_usage=100
#     else
#       cpu_usage=$(echo `echo "scale=7;100 * (($__diff_total / $__diff_idle) / $__diff_total)" | bc` | head -c3)
#     fi
#     __total_old[$i]=${__total[$i]}
#     __idle_old[$i]=$__idle
#     # echo "100 * ($__diff_total/$__diff_idle)"
#     __all=`echo $__all $cpu_usage`
#   done
#   __avg=$(echo "C["$(echo $(echo "scale=5;("`echo $__all | sed 's/ /+/g'`")/8" | bc) | egrep -o ".*\..")"] | ")
#   echo $__avg > $tmp_dir/cpu.out
#   sleep $_cpu
#   CPU
# }
# End cpu

THERMAL() {
  local __
  __=`sensors | grep Core`
  __=$(echo T\[$(echo \(`echo $__ | sed 's/.*+\(.*\).C\(\s\)\+(.*/\1/g' | tr "\n" "+" | head -c-1`\)\/`echo $__ | wc -l` | bc)\] \|)
  echo $__ > $tmp_dir/thermal.out
  sleep $_thermal
  THERMAL
}

DISK() {
  local __
  __=$(echo \| D\[`df -h --output=pcent / | tail -n1 | cut -c2-`\] )
  echo $__ > $tmp_dir/disk.out
  sleep $_disk
  DISK
}

DATE() {
  local __
  __=$(echo "%{c}" `date +%A\ \|\ %B\ %d,\ %Y\ \|%l:%M:%S\ %P` "%{r}")
  echo $__ > $tmp_dir/date.out
  sleep $_date
  DATE
}

MEM() {
  __mem=`cat -E /proc/meminfo`
  __m=$(echo \| M\[$(echo 'scale=1;' `echo $__mem | tr "$" "\n" | grep Active: | egrep -o "[0-9]+"` \/ 1048576 | bc)\/$(echo 'scale=1;' `echo $__mem | tr "$" "\n" | grep MemTotal | egrep -o "[0-9]+"` \/ 1048576 | bc)\] )
  echo $__m > $tmp_dir/mem.out
  sleep $_mem
  MEM
}

VOL() {
  __vol=`amixer sget Master`
  if [[ `echo $__vol | grep "\[off"` ]]; then
    __v="V[MM] |"
  else
    __v=$(echo V\[`echo $__vol | egrep -o "[0-9]+%"`\] \|)
  fi
  echo $__v > $tmp_dir/vol.out
  sleep $_vol
  VOL
}

BSPWM() {
  active_mon=`bspc query -T -d | head -n 2 | tail -n 1`
  active_mon=`echo $active_mon | sed 's/ .*//g'`
  mons=`bspc query -D`
  mons=`echo $mons`
  echo $mons | sed 's/ /  /g' | sed 's/\(^\|$\)/ /g' | sed "s/ \($active_mon\) /%{R} \1 %{R}/g" > $tmp_dir/bspwm.out.1
  mv $tmp_dir/bspwm.out.1 $tmp_dir/bspwm.out # Needed for spaces between desktops
  sleep $_bspwm
  BSPWM
}
# End scripts

# Init
DISPATCH() {
  BAT & THERMAL & DISK & DATE & MEM & VOL & BSPWM &
  OUTPUT | bar -p -B "#fff1b1d1e" -F "#fff8f8f8f" -f "-*-terminus-medium-r-normal--12-120-72-72-c-60-iso8859-1"
}
if [[ ! -d $tmp_dir ]]; then
  mkdir $tmp_dir
fi
DISPATCH
