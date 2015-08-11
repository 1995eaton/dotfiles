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

export XDG_CONFIG_HOME="$HOME/.config/"

xset +fp /usr/share/fonts/local &
xset +fp /home/jake/.fonts &
xset fp rehash &
urxvtd -q &
xsetroot -cursor_name left_ptr &
xrdb ~/.Xresources &
xmodmap /home/jake/.macros &
xset r rate 300 40 &
xset m 3/2.5 &
sh ~/.fehbg &
sxhkd &
python3 ~/source/chromium-vim/cvim_server.py &
wmname LG3D &
exec bspwm
# chromium &
# urxvt &
# exec compiz
