---
name: tmux-nvim
description: Use when opening or editing a file so the user can see it in neovim. Sends tmux commands to open the file in nvim on tmux window 2. Use after ANY file edit, create, or when the user asks to see/edit a file.
---

# Tmux Neovim File Opener

After editing, creating, or referencing a file, send it to neovim running in tmux window 2 so the user can view/edit it interactively.

## Command

```bash
tmux send-keys -t 0:2 ":e <full-filepath>" Enter
```

Replace `<full-filepath>` with the absolute path to the file.

## Rules

- Always use the **absolute path** (e.g. `/home/g/.config/hypr/hyprland/keybinds.conf`, not `~/.config/...`)
- Run the tmux send-keys command after EVERY file edit (edit tool or bash echo/cat writes)
- If the edit fails, do NOT send the tmux command
- Target is tmux session 0, window 2 (`-t 0:2`)
- The command uses nvim's `:e` (edit) command which opens the file in the current nvim buffer

## Examples

```bash
# Open keybinds config
tmux send-keys -t 0:2 ":e /home/g/.config/hypr/hyprland/keybinds.conf" Enter

# Open a plugin file
tmux send-keys -t 0:2 ":e /home/g/dotfiles/.config/nvim/lua/plugins/lualine.lua" Enter

# Open shell config
tmux send-keys -t 0:2 ":e /home/g/.config/caelestia/shell.json" Enter
```