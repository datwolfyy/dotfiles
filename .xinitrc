#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
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

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# dwm statusbar date
#while true; do
#	xsetroot -name "$( date +"%F %R" )"
#	sleep 1m
#done &


setxkbmap -model pc104alt -layout gb,hu -variant , -option grp:win_space_toggle
numlockx &
albert &
exec picom -b &
# Add wallpaper for dwm
#hsetroot -center /mnt/data/Downloads/wp/1_cut.jpg &
#exec dwm
exec awesome
