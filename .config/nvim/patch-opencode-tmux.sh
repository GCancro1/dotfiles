#!/usr/bin/env bash
# Patches opencode-tmux cleanup() to not kill the pane on nvim exit.
# Run via lazy.nvim build hook or manually: bash ~/.config/nvim/patch-opencode-tmux.sh

TMUX_LUA="$HOME/.local/share/nvim/lazy/opencode-tmux/lua/opencode-tmux/tmux.lua"

if [ ! -f "$TMUX_LUA" ]; then
    echo "patch-opencode-tmux: $TMUX_LUA not found, skipping"
    exit 0
fi

# Replace the cleanup function body with just "owned_pane = nil"
# Idempotent: always writes the same result
awk '
/^function M\.cleanup\(\)/ {
    print "function M.cleanup()"
    print "\towned_pane = nil"
    skip = 1
}
skip && /^end$/ {
    print "end"
    skip = 0
    next
}
!skip { print }
' "$TMUX_LUA" > "$TMUX_LUA.tmp" && mv "$TMUX_LUA.tmp" "$TMUX_LUA"

echo "patch-opencode-tmux: patched $TMUX_LUA"
