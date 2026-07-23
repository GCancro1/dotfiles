#!/usr/bin/env bash
# ============================================
# Dotfiles Bootstrap Script
# ============================================
# Usage on a fresh CachyOS install:
#   bash <(curl -fsSL <your-repo-url>/bootstrap.sh)
#
# Or manually:
#   git clone <repo-url> ~/dotfiles
#   bash ~/dotfiles/bootstrap.sh

set -e

DOTFILES_DIR="$HOME/dotfiles"

echo "╔══════════════════════════════════════╗"
echo "║     Dotfiles Bootstrap               ║"
echo "╚══════════════════════════════════════╝"

# --- Step 1: Clone dotfiles if not present ---
if [ ! -d "$DOTFILES_DIR" ]; then
    echo ""
    echo "[1/4] Cloning dotfiles..."
    # Replace with your actual repo URL
    git clone <YOUR_REPO_URL> "$DOTFILES_DIR"
else
    echo ""
    echo "[1/4] Dotfiles already present at $DOTFILES_DIR"
    cd "$DOTFILES_DIR" && git pull --ff-only
fi

cd "$DOTFILES_DIR"

# --- Step 2: Install system packages ---
echo ""
echo "[2/4] Installing packages from packages.txt..."

# Install yay (AUR helper) if not present
if ! command -v yay &> /dev/null; then
    echo "  Installing yay (AUR helper)..."
    sudo pacman -S --needed --noconfirm base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd "$DOTFILES_DIR"
    rm -rf /tmp/yay
fi

# Parse packages.txt and install
if [ -f packages.txt ]; then
    # Install pacman packages (everything before [aur])
    PACMAN_PKGS=$(sed '/^\[aur\]/,$d' packages.txt | grep -v '^#\|^$\|^$' | tr '\n' ' ')
    if [ -n "$PACMAN_PKGS" ]; then
        echo "  Installing pacman packages..."
        sudo pacman -S --needed --noconfirm $PACMAN_PKGS
    fi

    # Install AUR packages (everything after [aur])
    AUR_PKGS=$(sed -n '/^\[aur\]/,$ p' packages.txt | grep -v '^\[aur\]\|^#\|^$' | tr '\n' ' ')
    if [ -n "$AUR_PKGS" ]; then
        echo "  Installing AUR packages..."
        yay -S --needed --noconfirm $AUR_PKGS
    fi
else
    echo "  packages.txt not found, skipping package installation"
fi

# --- Step 3: Deploy dotfiles via stow ---
echo ""
echo "[3/4] Deploying configs via stow..."
bash "$DOTFILES_DIR/deploy.sh"

# --- Step 4: Verify ---
echo ""
echo "[4/4] Verifying..."
echo "  ~/.gitconfig -> $(readlink ~/.gitconfig 2>/dev/null || echo 'NOT A SYMLINK')"
echo "  ~/scripts    -> $(readlink ~/scripts 2>/dev/null || echo 'NOT A SYMLINK')"
echo "  ~/bashutils  -> $(readlink ~/bashutils 2>/dev/null || echo 'NOT A SYMLINK')"
echo "  ~/.config/nvim  -> $(readlink ~/.config/nvim 2>/dev/null || echo 'NOT A SYMLINK')"
echo "  ~/.config/kitty -> $(readlink ~/.config/kitty 2>/dev/null || echo 'NOT A SYMLINK')"

echo ""
echo "╔══════════════════════════════════════╗"
echo "║     Bootstrap Complete!              ║"
echo "╚══════════════════════════════════════╝"
echo ""
echo "You may need to:"
echo "  - Log out and back in for shell changes to take effect"
echo "  - Set up SSH keys: ssh-keygen -t ed25519"
echo "  - Clone caelestia: git clone <caelestia-url> ~/caelestia && bash ~/caelestia/deploy.sh"
