#!/usr/bin/env bash
# ============================================
# Dotfiles Bootstrap Script
# ============================================
# Usage on a fresh CachyOS install:
#   bash <(curl -fsSL <your-repo-url>/bootstrap.sh)           # dev tools only
#   bash <(curl -fsSL <your-repo-url>/bootstrap.sh) --hyprland # dev + hyprland desktop
#
# Or manually:
#   git clone <repo-url> ~/dotfiles
#   bash ~/dotfiles/bootstrap.sh

set -e

DOTFILES_DIR="$HOME/dotfiles"
INSTALL_HYPRLAND=false

# Parse flags
for arg in "$@"; do
    case $arg in
        --hyprland) INSTALL_HYPRLAND=true ;;
    esac
done

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

# --- Helper: install packages from a manifest file ---
install_packages() {
    local manifest="$1"
    local label="$2"

    if [ ! -f "$manifest" ]; then
        echo "  $manifest not found, skipping"
        return
    fi

    echo "  Installing $label packages..."

    # Install pacman packages (everything before [aur])
    PACMAN_PKGS=$(sed '/^\[aur\]/,$d' "$manifest" | grep -v '^#\|^$\|^\s*$' | tr '\n' ' ')
    if [ -n "$PACMAN_PKGS" ]; then
        sudo pacman -S --needed --noconfirm $PACMAN_PKGS
    fi

    # Install AUR packages (everything after [aur])
    AUR_PKGS=$(sed -n '/^\[aur\]/,$ p' "$manifest" | grep -v '^\[aur\]\|^#\|^$\|^\s*$' | tr '\n' ' ')
    if [ -n "$AUR_PKGS" ]; then
        yay -S --needed --noconfirm $AUR_PKGS
    fi
}

# --- Step 2: Install system packages ---
echo ""
echo "[2/4] Installing packages..."

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

# Always install dev packages
install_packages "packages-dev.txt" "development"

# Optionally install Hyprland packages
if [ "$INSTALL_HYPRLAND" = true ]; then
    install_packages "packages-hyprland.txt" "Hyprland desktop"
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
if [ "$INSTALL_HYPRLAND" = true ]; then
    echo "  - Clone caelestia: git clone <caelestia-url> ~/caelestia && bash ~/caelestia/deploy.sh"
fi
