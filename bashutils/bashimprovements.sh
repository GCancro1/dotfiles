# ~/.bashrc
# ==================================================
# History
# ==================================================

# Append to history instead of overwriting it
shopt -s histappend

# Large history
HISTSIZE=50000
HISTFILESIZE=100000

# Ignore duplicates and commands starting with a space
HISTCONTROL=ignoreboth

# Check terminal size after each command
shopt -s checkwinsize

# Save history immediately
PROMPT_COMMAND='history -a'

# ==================================================
# Better History Search
# ==================================================

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# ==================================================
# PATH Management
# ==================================================

pathadd() {
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$1:$PATH" ;;
    esac
}

pathadd "$HOME/bin"
pathadd "$HOME/.local/bin"

export PATH

# ==================================================
# Aliases
# ==================================================

# # Listing
# alias ll='ls -alF'
# alias la='ls -A'
# alias l='ls -CF'
#
# # Safer file operations
# alias cp='cp -i'
# alias mv='mv -i'
# alias rm='rm -i'
#
# # Navigation
# alias ..='cd ..'
# alias ...='cd ../..'
# alias ....='cd ../../..'
#
# # System
# alias reload='source ~/.bashrc'
# alias df='df -h'
# alias du='du -h'
# alias free='free -h'
#
# # Networking
# alias myip='curl -s ifconfig.me'
# alias ports='ss -tulpen'
#
# # SSH
# alias sshconfig='${EDITOR:-nano} ~/.ssh/config'
#
# ==================================================
# Modern CLI Tools (only if installed)
# ==================================================

command -v eza >/dev/null && alias ll='eza -la --icons'

command -v bat >/dev/null 

# ==================================================
# Git Aliases
# ==================================================

# alias gs='git status'
# alias ga='git add'
# alias gc='git commit'
# alias gp='git push'
# alias gl='git log --oneline --graph --decorate --all'
# alias gd='git diff'
# alias gco='git checkout'
# alias gb='git branch'
#
# ==================================================
# Functions
# ==================================================

# Make directory and enter it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Current git branch
branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null
}

# Search processes
psg() {
    ps aux | grep -i "$1" | grep -v grep
}

# Create and activate Python venv
venv() {
    python3 -m venv .venv
    source .venv/bin/activate
}

# Extract archives
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz)  tar xzf "$1" ;;
            *.bz2)     bunzip2 "$1" ;;
            *.rar)     unrar x "$1" ;;
            *.gz)      gunzip "$1" ;;
            *.tar)     tar xf "$1" ;;
            *.tbz2)    tar xjf "$1" ;;
            *.tgz)     tar xzf "$1" ;;
            *.zip)     unzip "$1" ;;
            *.7z)      7z x "$1" ;;
            *) echo "Unknown archive type: $1" ;;
        esac
    else
        echo "File not found: $1"
    fi
}

# ==================================================
# Git Prompt Support
# ==================================================

parse_git_branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null
}

# ==================================================
# Prompt
# ==================================================

PS1='\[\e[32m\]\u@\h\[\e[0m\]:\[\e[34m\]\w\[\e[33m\]$(b=$(parse_git_branch); [ -n "$b" ] && echo " [$b]")\[\e[0m\]-\$ '

# ==================================================
# Bash Completion
# ==================================================

if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

# ==================================================
# fzf Integration (if installed)
# ==================================================

if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --bash)"
fi

# ==================================================
# Editor Preference
# ==================================================

export EDITOR=nvim
export VISUAL="$EDITOR"

# ==================================================
# Useful Environment Variables
# ==================================================

# export LESS='-R'
# export PAGER='less'
#
# ==================================================
# End of ~/.bashrc
# ==================================================
