#!/usr/bin/env bash

SESSION="dev"

tmux has-session -t "$SESSION" 2>/dev/null
if [ $? -eq 0 ]; then
  tmux attach -t "$SESSION"
  exit
fi

# window 1: regular terminal
tmux new-session -d -s "$SESSION" -n "term"

# window 2: nvim
tmux new-window -t "$SESSION:2" -n "nvim"
tmux send-keys -t "$SESSION:2" "nvim" Enter

# window 3: two opencode panes side by side
tmux new-window -t "$SESSION:3" -n "opencode"
tmux send-keys -t "$SESSION:3" "opencode" Enter
tmux split-window -h -t "$SESSION:3" -c "#{pane_current_path}"
tmux send-keys -t "$SESSION:3" "opencode" Enter

# window 4: regular terminal
tmux new-window -t "$SESSION:4" -n "term"

tmux select-window -t "$SESSION:1"
tmux attach -t "$SESSION"
