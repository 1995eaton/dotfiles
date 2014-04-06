cd `dirname $0`

on() {
  cpos=`cat mloc`
  rm mloc
  synclient TouchpadOff=0
  xsetroot -cursor_name left_ptr
  xdotool mousemove $cpos
}

off() {
  mloc=`xdotool getmouselocation`
  x=`echo $mloc | egrep -o "x:([0-9])+" | cut -c3-`
  y=`echo $mloc | egrep -o "y:([0-9])+" | cut -c3-`
  xsetroot -cursor empty empty
  xdotool mousemove 1920 1080
  synclient TouchpadOff=1
  echo $x $y > mloc
}

if [[ ! -f mloc ]]; then
  off
else
  on
fi

cd -
