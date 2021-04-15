#!/bin/sh
set -e

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
xrandrrc=$HOME/.xrandrrc
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

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

if [ -f "$xrandrrc" ]; then
    sh $xrandrrc
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

setterm -blank 0 -powersave off -powerdown 0
xset s off

# Increase the repeat rate
xset r rate 175 40

# Network manager applet
nm-applet --sm-disable &
setxkbmap dvorak

pasystray & disown
#systemctl --user restart redshift

#exec xterm -geometry 80x66+0+0 -name login
exec awesome
