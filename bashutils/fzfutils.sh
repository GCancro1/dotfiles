# Use bat as the default preview
export FZF_DEFAULT_OPTS="--preview 'bat --color=always --style=numbers --line-range :300 {}'"

# Fuzzy‑search files (with bat preview)
ff() {
    local file
    file=$(find . -type f -not -path '*/\.*' | fzf --preview 'bat --color=always --style=numbers {}')
    [ -n "$file" ] && echo "$file"
}

# Fuzzy‑search and cd into directories
fd() {
    local dir
    dir=$(find . -type d -not -path '*/\.*' | fzf --preview 'ls -la {}')
    [ -n "$dir" ] && cd "$dir"
}

# Use fzf for history search (Ctrl‑R)
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap"

# gb with fzf: fuzzy‑pick a bookmark
gbf() {
    local line
    line=$(awk -F'\t' '{print $1 "\t" $2}' ~/.bookmarks | fzf --preview 'ls -la {2}')
    [ -n "$line" ] && cd "$(echo "$line" | cut -f2)"
}


# Fuzzy search file contents with rg + fzf + bat preview
rgf() {
    local file
    file=$(rg --files-with-matches "$@" | fzf --preview 'bat --color=always --style=numbers {}')
    [ -n "$file" ] && echo "$file"
}

# Jump to file and line from rg output (if you pipe rg -n output)
rgj() {
    local line
    line=$(rg --line-number "$@" | fzf --preview 'bat --color=always --style=numbers {1}')
    if [ -n "$line" ]; then
        local file=$(echo "$line" | cut -d: -f1)
        local lineno=$(echo "$line" | cut -d: -f2)
        [ -n "$file" ] && [ -n "$lineno" ] && nvim "+$lineno" "$file"
    fi
}

# ~/.bashrc
bind -x '"\C-t": rg --files | fzf --preview "bat --color=always --style=numbers {}" | xargs -r -I{} echo {} > /tmp/fzf_file'
bind '"\C-r": \C-ahistory | fzf --preview  "bat --color=always {}" \C-j'


fopen() {
    [ -f /tmp/fzf_file ] && cat /tmp/fzf_file | xargs -r nvim
}


# Fuzzy keybindings cheat sheet
kbs() {
    if [ ! -f "$HOME/.config/bash/bashkeyb.txt" ]; then
        echo "No bashkeyb.txt found. Create ~/.config/keys.txt with your bindings."
        return 1
    fi
    fzf --height=80% --reverse --border --info=inline \
        --prompt='Keybindings> ' \
        --preview 'echo "KEYBINDINGS CHEAT SHEET" && bat --color=always --style=numbers ~/.config/bash/bashkeyb.txt' \
        < ~/.config/bash/bashkeyb.txt
}
bind -x '"\C-k": kbs'
