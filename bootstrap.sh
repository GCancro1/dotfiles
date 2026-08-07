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
    # On CachyOS, yay resolves quickshell-git to noctalia-qs (a fork that
    # provides quickshell-git but is incompatible with Caelestia). We must:
    # 1. Remove all noctalia packages
    # 2. Build quickshell-git directly from AUR using makepkg (bypass yay)
    # 3. Pin noctalia-qs out so yay can't pull it back in

    NEEDS_QUICKSHELL=false

    if pacman -Qi noctalia-qs &> /dev/null || pacman -Qi noctalia-qs-git &> /dev/null; then
        echo "  noctalia-qs detected (incompatible with Caelestia)..."
        NEEDS_QUICKSHELL=true
    elif ! command -v qs &> /dev/null; then
        echo "  Quickshell not installed..."
        NEEDS_QUICKSHELL=true
    elif qs --version 2>&1 | grep -qi "noctalia"; then
        echo "  noctalia-qs detected via qs binary..."
        NEEDS_QUICKSHELL=true
    fi

    if [ "$NEEDS_QUICKSHELL" = true ]; then
        # Break dependency chain: remove caelestia-shell first
        if pacman -Qi caelestia-shell &> /dev/null || pacman -Qi caelestia-shell-git &> /dev/null; then
            echo "  Removing caelestia-shell to break dependency chain..."
            sudo pacman -Rns --noconfirm caelestia-shell caelestia-shell-git 2>/dev/null
        fi

        # Remove ALL noctalia packages
        for pkg in noctalia-qs noctalia-qs-git noctalia-shell noctalia-shell-git; do
            if pacman -Qi "$pkg" &> /dev/null; then
                echo "  Removing $pkg..."
                sudo pacman -Rns --noconfirm "$pkg" 2>/dev/null
            fi
        done

        # Build quickshell-git directly from AUR (bypass yay resolution)
        echo "  Building Quickshell from AUR..."
        rm -rf /tmp/quickshell-git-aur
        git clone https://aur.archlinux.org/quickshell-git.git /tmp/quickshell-git-aur
        cd /tmp/quickshell-git-aur
        makepkg -si --noconfirm
        cd "$DOTFILES_DIR"
        rm -rf /tmp/quickshell-git-aur

        if command -v qs &> /dev/null; then
            echo "  Quickshell installed: $(qs --version 2>&1 | head -1)"
        else
            echo "  Error: Quickshell installation failed"
            echo "  Please install manually:"
            echo "    git clone https://aur.archlinux.org/quickshell-git.git /tmp/qs"
            echo "    cd /tmp/qs && makepkg -si && cd ~ && rm -rf /tmp/qs"
        fi
    else
        echo "  Quickshell already installed ($(qs --version 2>&1 | head -1))"
    fi

    # Block noctalia packages in pacman.conf so yay can't pull them back in
    NOCTALIA_BLOCK="# Block noctalia-qs (incompatible with Caelestia, provides quickshell-git)
IgnorePkg = noctalia-qs noctalia-qs-git"
    if ! grep -q "noctalia-qs" /etc/pacman.conf 2>/dev/null; then
        echo "  Blocking noctalia-qs in pacman.conf..."
        echo "$NOCTALIA_BLOCK" | sudo tee -a /etc/pacman.conf > /dev/null
    fi

    # Also pin real quickshell-git so pacman doesn't replace it
    if ! grep -q "IgnorePkg.*quickshell-git" /etc/pacman.conf 2>/dev/null; then
        echo "  Pinning Quickshell in pacman.conf..."
        sudo sed -i 's/^#\(IgnorePkg = noctalia.*\)/\1 quickshell-git/' /etc/pacman.conf 2>/dev/null
        # If no existing IgnorePkg line matched, add it
        if ! grep -q "quickshell-git" /etc/pacman.conf 2>/dev/null; then
            echo "IgnorePkg = quickshell-git" | sudo tee -a /etc/pacman.conf > /dev/null
        fi
    fi

    # Install caelestia-shell from AUR
    # Use --assume-installed to prevent yay from re-resolving quickshell-git
    echo "  Installing Caelestia shell..."
    if yay -S --needed --noconfirm caelestia-shell --assume-installed quickshell-git; then
        echo "  Caelestia shell installed successfully"
    else
        echo "  Warning: Could not install caelestia-shell, trying caelestia-shell-git..."
        yay -S --needed --noconfirm caelestia-shell-git --assume-installed quickshell-git || {
            echo "  Error: Could not install Caelestia shell"
            echo "  Please install manually: yay -S caelestia-shell --assume-installed quickshell-git"
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
    if pacman -Qi noctalia-qs &> /dev/null || pacman -Qi noctalia-qs-git &> /dev/null || \
       pacman -Qi noctalia-shell &> /dev/null || pacman -Qi noctalia-shell-git &> /dev/null; then
        echo "  noctalia packages   -> CONFLICT! Run: sudo pacman -Rns noctalia-qs noctalia-qs-git noctalia-shell noctalia-shell-git"
    else
        echo "  noctalia packages   -> not installed (good)"
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
