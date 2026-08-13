#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias nh='nvim ~/.config/hypr/hyprland.conf'
alias nv='nvim ~/.config/nvim/lua/plugins/'
alias nb='nvim ~/.bashrc'
alias nt='nvim ~/.tmux.conf'
alias na='nvim /home/g/dotfiles/.config/opencode/AGENTS.md'
alias v='nvim'
alias oc='opencode'
alias yt='mov-cli -s youtube'

export c4="$HOME/.config/"
# PS1='[\u@\h \W]\$ '

mkcd () {
    mkdir -p -- "$1" && cd -P -- "$1"
}

# --- Extrakt: pull text from tmux pane via fzf ---
# Triggered via Ctrl+y inside tmux (see tmux.conf)

if [[ -z $WAYLAND_DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec Hyprland
fi


source ~/bashutils/bashimprovements.sh
source /usr/share/fzf/key-bindings.bash
# source ~/bashutils/fzfutils.sh

# LuaRocks paths for image.nvim (magick module)
export LUA_PATH='/usr/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/usr/share/lua/5.1/?/init.lua;/usr/local/lib/lua/5.1/?.lua;/usr/local/lib/lua/5.1/?/init.lua;/usr/lib/lua/5.1/?.lua;/usr/lib/lua/5.1/?/init.lua;./?.lua;./?/init.lua;/home/g/.luarocks/share/lua/5.1/?.lua;/home/g/.luarocks/share/lua/5.1/?/init.lua'
export LUA_CPATH='/usr/local/lib/lua/5.1/?.so;/usr/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so;/usr/lib/lua/5.1/loadall.so;./?.so;/home/g/.luarocks/lib/lua/5.1/?.so'
export PATH="/home/g/.luarocks/bin:$PATH"
