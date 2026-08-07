# Dotfiles

Personal dotfiles managed with GNU Stow. Supports a development environment and a full Hyprland desktop powered by Caelestia.

## Contents

- **Hyprland** - Window manager, keybinds, decorations, animations, rules
- **Caelestia** - Quickshell-based desktop shell (launcher, bar, notifications, media, system controls)
- **Kitty** - Terminal emulator
- **Neovim** - Editor (LazyVim-adjacent with custom plugins)
- **Tmux** - Terminal multiplexer
- **Fuzzel** - Application launcher (clipboard/emoji picker)
- **Bash** - Shell config

## Prerequisites

- Arch Linux (or Arch-based distro)
- `yay` (AUR helper) - installed automatically by bootstrap if missing
- `stow` - for symlink deployment
- `git`

## Bootstrap

```bash
# Clone the repo
git clone <your-repo-url> ~/dotfiles

# Dev tools only
bash ~/dotfiles/bootstrap.sh

# Dev tools + Hyprland desktop (includes Caelestia)
bash ~/dotfiles/bootstrap.sh --hyprland
```

## What Gets Installed

### Always (packages-dev.txt)
- Core tools: stow, base-devel
- Terminal: kitty, fish, tmux, fzf
- Editor: neovim
- System utils: bat, btop, ncdu, duf, fd, ripgrep, jq
- Dev: nodejs, npm, python-pipx
- Fonts: JetBrains Mono Nerd, Nerd Font Symbols

### With --hyprland (packages-hyprland.txt)
- Hyprland compositor and plugins
- Portals: xdg-desktop-portal-hyprland, gtk
- Shell: waybar, mako, cliphist, wl-clipboard
- File manager: thunar
- Screenshots: grim, slurp
- Brightness: brightnessctl
- Keyring: gnome-keyring, polkit-gnome
- Blue light: gammastep, geoclue
- Bluetooth: mpris-proxy
- Utilities: trash-cli, hyprpicker, ydotool
- AUR: app2unit, nwg-look, nwg-displays, caelestia-meta (includes Caelestia CLI)

## Manual Steps After Bootstrap

1. **SSH keys**: `ssh-keygen -t ed25519`
2. **Caelestia reinstall** (if needed): `caelestia install`
3. **Wallpaper**: Type `>` in the Caelestia launcher and search for "wallpaper"
4. **Font scaling**: Edit `~/.config/caelestia/shell.json` and set `font_size` to `18` or `20`

## Structure

```
~/dotfiles/
  bootstrap.sh              # One-command setup script
  deploy.sh                 # Stow deployment script
  packages-dev.txt          # Development package manifest
  packages-hyprland.txt     # Hyprland desktop package manifest
  .config/
    hypr/                   # Hyprland config (modular conf files)
    caelestia/              # Caelestia overrides
    kitty/                  # Terminal config
    nvim/                   # Neovim config
    fuzzel/                 # Fuzzel launcher config
```

## Updating

```bash
cd ~/dotfiles
git pull
stow --restow .
```
