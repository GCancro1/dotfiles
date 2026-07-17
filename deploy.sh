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

# Backup any existing files/dirs that would conflict with stow
# (stow won't overwrite existing files, so we move them first)
for item in .bashrc .bash_profile .tmux.conf; do
    if [ -f "$HOME/$item" ] && [ ! -L "$HOME/$item" ]; then
        mv "$HOME/$item" "$BACKUP_DIR/"
        echo "  Backed up: $item"
    fi
done

# Backup .config directories that exist and aren't already symlinks
for dir in "$HOME/.config"/*/; do
    dir_name=$(basename "$dir")
    if [ ! -L "$HOME/.config/$dir_name" ]; then
        # Check if this dir exists in our dotfiles (will be stowed)
        if [ -d "$DOTFILES_DIR/.config/$dir_name" ]; then
            mv "$HOME/.config/$dir_name" "$BACKUP_DIR/"
            echo "  Backed up: .config/$dir_name"
        fi
    fi
done

echo "  Backups saved to $BACKUP_DIR"

echo "[3/3] Creating symlinks with stow..."
cd "$DOTFILES_DIR"

# Use --restow to cleanly remove and re-create symlinks
# This handles both existing stow symlinks and non-stow symlinks
stow --restow .

echo "  Stow completed successfully"

echo ""
echo "=== Done! ==="
echo "Your configs are now symlinked from ~/dotfiles/"
echo "Backup of old configs: $BACKUP_DIR"
