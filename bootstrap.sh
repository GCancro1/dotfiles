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
    echo "[1/5] Cloning dotfiles..."
    # Replace with your actual repo URL
    git clone <YOUR_REPO_URL> "$DOTFILES_DIR"
else
    echo ""
    echo "[1/5] Dotfiles already present at $DOTFILES_DIR"
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
echo "[2/5] Installing packages..."

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
echo "[3/5] Deploying configs via stow..."
bash "$DOTFILES_DIR/deploy.sh"

# --- Step 4: Install Caelestia (Hyprland desktop) ---
if [ "$INSTALL_HYPRLAND" = true ]; then
    echo ""
    echo "[4/5] Installing Caelestia..."

    # Ensure fish is installed (required by Caelestia)
    if ! command -v fish &> /dev/null; then
        echo "  Installing fish shell (required by Caelestia)..."
        sudo pacman -S --needed --noconfirm fish
    fi

    # Ensure yay is available for AUR
    if ! command -v yay &> /dev/null; then
        echo "  Installing yay (AUR helper)..."
        sudo pacman -S --needed --noconfirm base-devel
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay && makepkg -si --noconfirm && cd "$DOTFILES_DIR"
        rm -rf /tmp/yay
    fi

    # --- Fix noctalia-qs / quickshell-git conflict ---
    # noctalia-qs provides quickshell-git (so yay thinks it's fine) but it's
    # incompatible with Caelestia (missing DefaultEnv pragma support).
    # Must break the dependency chain: remove caelestia-shell first, then
    # noctalia-qs, then install real quickshell-git, then reinstall caelestia-shell.

    NEEDS_QUICKSHELL_FIX=false

    if pacman -Qi noctalia-qs &> /dev/null; then
        echo "  noctalia-qs detected (incompatible with Caelestia)..."
        NEEDS_QUICKSHELL_FIX=true

        # Step A: Remove caelestia-shell first (breaks dependency on noctalia-qs)
        if pacman -Qi caelestia-shell &> /dev/null || pacman -Qi caelestia-shell-git &> /dev/null; then
            echo "  Removing caelestia-shell to break dependency chain..."
            sudo pacman -Rns --noconfirm caelestia-shell caelestia-shell-git 2>/dev/null
        fi

        # Step B: Now remove noctalia-qs (no more blockers)
        echo "  Removing noctalia-qs..."
        sudo pacman -Rns --noconfirm noctalia-qs

        # Step C: Install real quickshell-git from AUR
        echo "  Installing real Quickshell from AUR..."
        if yay -S --needed --noconfirm quickshell-git; then
            echo "  Quickshell installed successfully"
        else
            echo "  Error: Failed to install quickshell-git"
            echo "  Please install manually: yay -S quickshell-git"
        fi
    elif ! command -v qs &> /dev/null; then
        # Quickshell not installed at all
        echo "  Installing Quickshell from AUR..."
        yay -S --needed --noconfirm quickshell-git || {
            echo "  Error: Failed to install quickshell-git"
            echo "  Please install manually: yay -S quickshell-git"
        }
    else
        # Check if it's real quickshell (not noctalia-qs)
        if qs --version 2>&1 | grep -qi "noctalia"; then
            echo "  Detected noctalia-qs in disguise, fixing..."
            NEEDS_QUICKSHELL_FIX=true
            sudo pacman -Rns --noconfirm caelestia-shell caelestia-shell-git 2>/dev/null
            sudo pacman -Rns --noconfirm noctalia-qs 2>/dev/null
            yay -S --needed --noconfirm quickshell-git || {
                echo "  Error: Failed to install quickshell-git"
            }
        else
            echo "  Quickshell already installed ($(qs --version 2>&1 | head -1))"
        fi
    fi

    # Pin Quickshell so pacman/CAELESTIA doesn't replace with noctalia-qs
    if ! grep -q "IgnorePkg.*quickshell-git" /etc/pacman.conf 2>/dev/null; then
        echo "  Pinning Quickshell in pacman.conf..."
        echo "IgnorePkg = quickshell-git" | sudo tee -a /etc/pacman.conf > /dev/null
        echo "  Quickshell pinned (won't be replaced by noctalia-qs)"
    fi

    # Install caelestia-shell from AUR (or reinstall after fixing conflict)
    echo "  Installing Caelestia shell..."
    if yay -S --needed --noconfirm caelestia-shell; then
        echo "  Caelestia shell installed successfully"
    else
        echo "  Warning: Could not install caelestia-shell, trying caelestia-shell-git..."
        yay -S --needed --noconfirm caelestia-shell-git || {
            echo "  Error: Could not install Caelestia shell"
            echo "  Please install manually: yay -S caelestia-shell"
        }
    fi

    # Clone the Caelestia dotfiles for config
    CAELESTIA_DIR="$HOME/.config/caelestia"
    if [ ! -d "$CAELESTIA_DIR" ]; then
        echo "  Cloning Caelestia dotfiles..."
        git clone https://github.com/caelestia-dots/caelestia.git /tmp/caelestia-dots
        echo "  Copying Caelestia config..."
        mkdir -p "$HOME/.config/caelestia"
        cp -r /tmp/caelestia-dots/caelestia/. "$HOME/.config/caelestia/"
        rm -rf /tmp/caelestia-dots
        echo "  Caelestia dotfiles installed to ~/.config/caelestia/"
    else
        echo "  Caelestia config already exists at $CAELESTIA_DIR"
    fi
else
    echo ""
    echo "[4/5] Skipping Caelestia (not a Hyprland install)"
fi

# --- Step 5: Verify ---
echo ""
echo "[5/5] Verifying..."
echo "  ~/.config/hypr      -> $(readlink ~/.config/hypr 2>/dev/null || echo 'NOT A SYMLINK')"
echo "  ~/.config/kitty     -> $(readlink ~/.config/kitty 2>/dev/null || echo 'NOT A SYMLINK')"
echo "  ~/.config/nvim      -> $(readlink ~/.config/nvim 2>/dev/null || echo 'NOT A SYMLINK')"
echo "  ~/.config/fuzzel    -> $(readlink ~/.config/fuzzel 2>/dev/null || echo 'NOT A SYMLINK')"
if [ "$INSTALL_HYPRLAND" = true ]; then
    if command -v qs &> /dev/null; then
        echo "  Quickshell          -> INSTALLED ($(qs --version 2>&1 | head -1))"
    else
        echo "  Quickshell          -> NOT FOUND"
    fi
    if pacman -Qi noctalia-qs &> /dev/null; then
        echo "  noctalia-qs         -> CONFLICT! Run: sudo pacman -Rns noctalia-qs"
    else
        echo "  noctalia-qs         -> not installed (good)"
    fi
    if command -v caelestia &> /dev/null; then
        echo "  Caelestia CLI       -> INSTALLED"
    else
        echo "  Caelestia CLI       -> NOT FOUND"
    fi
fi

echo ""
echo "╔══════════════════════════════════════╗"
echo "║     Bootstrap Complete!              ║"
echo "╚══════════════════════════════════════╝"
echo ""
echo "You may need to:"
echo "  - Log out and back in for shell changes to take effect"
echo "  - Set up SSH keys: ssh-keygen -t ed25519"
if [ "$INSTALL_HYPRLAND" = true ]; then
    echo "  - Re-run Caelestia install if issues: caelestia install"
fi
