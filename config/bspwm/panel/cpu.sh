#!/bin/sh

INTERVAL=$1

CPU() {
  _info=(`cat /proc/stat | grep "^cpu " | sed 's/cpu //'`)
  _idle=${_info[3]}
  _total=$(python -c "print(`echo ${_info[*]} | sed 's/ /+/g'`)")

  sleep 1

  _info2=(`cat /proc/stat | grep "^cpu " | sed 's/cpu //'`)
  _idle2=${_info2[3]}
  _total2=$(python -c "print(`echo ${_info2[*]} | sed 's/ /+/g'`)")


  diff_idle=`python -c "print($_idle2-$_idle)"`
  diff_total=`python -c "print($_total2-$_total)"`

  _perc="`python -c "print(round(100.0*($diff_total-$diff_idle)/$diff_total, 2))"`%"

  echo $_perc > data/cpu.txt

  sleep $INTERVAL

  CPU

}

CPU
