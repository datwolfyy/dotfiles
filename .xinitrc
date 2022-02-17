#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

export SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0
export QT_QPA_PLATFORMTHEME=qt5ct
xset b 0
/usr/libexec/xfce-polkit &
#mpd --no-daemon &
#udiskie -n -t -A &
exec dbus-run-session awesome
