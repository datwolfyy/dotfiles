# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='\[\e[0;1;36m\]\u\[\e[m\]@\[\e[0;1;32m\]\h\[\e[m\]:\W \[\e[1m\]\$\[\e[m\] '
export PATH="${PATH}:${HOME}/.local/bin"
export PATH="${PATH}:${HOME}/dmenu"
export SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0
