#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias nh='nvim ~/.config/hypr/hyprland.conf'
alias nv='nvim ~/.config/nvim/lua/biglazy.lua'
alias nb='nvim ~/.bashrc'
alias v='nvim'
alias yt='mov-cli -s youtube'

export c4="$HOME/.config/"
# PS1='[\u@\h \W]\$ '

mkcd () {
    mkdir -p -- "$1" && cd -P -- "$1"
}

if [[ -z $WAYLAND_DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec Hyprland
fi


source ~/bashutils/bashimprovements.sh
# source /usr/share/fzf/key-bindings.bash
# source ~/bashutils/fzfutils.sh
