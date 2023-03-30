# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias mic-test='arecord --channels=1 --duration=2 --format=dat --vumeter=stereo /tmp/test.wav'
alias x='startx'
alias ls='ls --color=auto'
alias wacom-osu='xsetwacom set 14 MapToOutput HDMI-A-0 && xsetwacom set 14 Area 4000 3100 10120 7200'
alias wacom-reset='xsetwacom set 14 ResetArea'

#source /usr/share/doc/pkgfile/command-not-found.bash
# nge theme: 38;5;166
# cthulu theme: 38;5;30
PS1='\[\e[38;5;160;1m\]\u\[\e[m\]@\[\e[38;5;33;1m\]\h\[\e[m\]:\W \[\e[1m\]\$\[\e[m\] '

export EDITOR="vim"
export PATH="${PATH}:${HOME}/.local/bin"
export RUA_SUDO_COMMAND="doas"
export OPENAI_KEY="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"
