#!/bin/bash

function run {
	if ! pgrep -f $1 ;
	then
		$@&
	fi
}
#run spotifyd --no-daemon >/dev/null &
run picom
run mpd --no-daemon --stderr  ~/.config/mpd/mpd.conf
run udiskie -A -n -t
run openrazer-daemon -F
