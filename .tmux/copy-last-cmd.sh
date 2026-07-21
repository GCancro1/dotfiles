#!/usr/bin/env bash
# Copies output of the last command (since last prompt) to clipboard
tmux capture-pane -p | awk '
  { lines[NR] = $0 }
  /@.*:.*\$/ { prev = cur; cur = NR }
  END {
    if (prev) {
      for (i = prev + 1; i < cur; i++) {
        if (i > prev + 1) printf "\n"
        printf "%s", lines[i]
      }
    }
  }
' | wl-copy
