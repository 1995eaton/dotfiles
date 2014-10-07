#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

if [ -f $sysresources ]; then
  xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# xterm -geometry 80x50+494+51 &
# xterm -geometry 80x20+494-0 &
# exec xterm -geometry 80x66+0+0 -name login
#
# GENERAL
xset +fp /usr/share/fonts/local
xset +fp /home/jake/.fonts
xset fp rehash

# exec mcwm

# compton &
# urxvtd -q &
# xsetroot -cursor_name left_ptr &
# xrdb ~/.Xresources &
# xmodmap /home/jake/.macros &
# nitrogen --restore &
# xset r rate 300 40 &
# xset m 3/2.5 &
# python3 ~/source/chromium-vim/cvim_socket.py &
# exec /home/jake/window

sxhkd &
exec bspwm
