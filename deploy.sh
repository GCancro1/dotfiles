#!/bin/bash
# Dotfiles deploy script
# Usage: curl -fsSL <your-repo-url>/deploy.sh | bash
# Or: git clone <repo> ~/dotfiles && bash ~/dotfiles/deploy.sh

set -e

DOTFILES_DIR="$HOME/dotfiles"

echo "=== Dotfiles Deploy ==="

# Check if dotfiles repo exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "ERROR: $DOTFILES_DIR not found. Clone your dotfiles repo first."
    exit 1
fi

echo "[1/3] Installing stow..."
if command -v stow &> /dev/null; then
    echo "  stow already installed"
else
    if command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm stow
    elif command -v apt &> /dev/null; then
        sudo apt update && sudo apt install -y stow
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y stow
    else
        echo "  Could not detect package manager. Install stow manually."
        exit 1
    fi
fi

echo "[2/3] Backing up existing configs..."
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Backup files that will be stowed
for item in .bashrc .bash_profile .tmux.conf; do
    if [ -f "$HOME/$item" ] && [ ! -L "$HOME/$item" ]; then
        mv "$HOME/$item" "$BACKUP_DIR/"
    fi
done

for dir in kitty nvim caelestia mpv fuzzel cava yt-dlp; do
    if [ -d "$HOME/.config/$dir" ] && [ ! -L "$HOME/.config/$dir" ]; then
        mv "$HOME/.config/$dir" "$BACKUP_DIR/"
    fi
done

echo "  Backups saved to $BACKUP_DIR"

echo "[3/3] Creating symlinks with stow..."
cd "$DOTFILES_DIR"
stow .

echo ""
echo "=== Done! ==="
echo "Your configs are now symlinked from ~/dotfiles/"
echo "Backup of old configs: $BACKUP_DIR"
