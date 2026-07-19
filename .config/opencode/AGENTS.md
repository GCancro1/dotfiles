# System

- Arch Linux, Hyprland compositor, Caelestia shell
- Shell: bash, terminal: kitty, multiplexer: tmux
- Editor: neovim (lazyvim-adjacent with custom plugin config)
- All dev env setup on this system needs to be easily copyable and syncable to other machines 

# Dotfiles Sync


- `~/dotfiles` is the git-tracked stow repo
- `~/.config/*` dirs are stowed symlinks pointing into `~/dotfiles/.config/`
- All config changes MUST be made via the dotfiles path so stow/git stay in sync
- Deploy: `cd ~/dotfiles && stow --restow .`

# Common Config Paths

| What | Path |
|------|------|
| Hyprland main | `~/.config/hypr/hyprland.conf` |
| Hyprland modules | `~/.config/hypr/hyprland/*.conf` (keybinds, rules, env, etc.) |
| Caelestia hypr vars | `~/.config/caelestia/hypr-vars.conf` |
| Caelestia hypr user | `~/.config/caelestia/hypr-user.conf` |
| Caelestia shell | `~/.config/caelestia/shell.json` |
| Neovim plugins | `~/dotfiles/.config/nvim/lua/plugins/` |
| Bashrc | `~/dotfiles/.bashrc` |
| Tmux | `~/dotfiles/.tmux.conf` |
| Tmux plugins | `~/.tmux/plugins.conf` |
| Opencode config | `~/dotfiles/.config/opencode/opencode.jsonc` |
| Kitty | `~/dotfiles/.config/kitty/` |

# Hyprland Structure

Hyprland config is modular: `hyprland.conf` sources separate files from `~/.config/hypr/hyprland/` (env, general, input, misc, animations, decoration, group, execs, rules, gestures, keybinds, scrolling). Caelestia overrides live in `~/.config/caelestia/hypr-vars.conf` and `hypr-user.conf`.

# Config Philosophy

- **Only configure current/active configs.** Never modify, reference, or suggest changes to old, backup, or archived config files unless explicitly asked.
- Ignore files matching patterns like `*OLD*`, `*old*`, `*backup*`, `*.bak`, `*_archive*`, `setuplazy*`, `oldbinds*`, `vimport*` in any config directory.
- Never modify `oldbinds.lua` or `vimport.lua` — they are legacy files that should be left as-is.
- Archived configs live in `~/dotfiles/.nvim-archive/` — do not touch unless the user asks.
- When exploring a config (e.g. nvim), focus on `init.lua`, `lua/plugins/`, and any actively `require`d modules. Skip anything that looks like a legacy/monolith file.

