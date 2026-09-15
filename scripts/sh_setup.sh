#!/bin/bash
#
# Modern CLI Tools Setup Script (Bash Only)
# Configures a fresh system with modern replacements for traditional Unix tools
#
# Supports: Arch Linux, Ubuntu, Windows (winget)
#
# Usage: chmod +x sh_setup.sh && ./sh_setup.sh

set -e

[[ $EUID -ne 0 ]] && SUDO="sudo" || SUDO=""

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() { echo -e "${BLUE}[*]${NC} $1"; }
print_success() { echo -e "${GREEN}[+]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[!]${NC} $1"; }
print_error() { echo -e "${RED}[-]${NC} $1"; }

detect_os() {
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || -n "$WINDIR" ]]; then
        OS="windows"
    elif [ -f /etc/arch-release ]; then
        OS="arch"
    elif [ -f /etc/debian_version ]; then
        OS="ubuntu"
    else
        print_error "Unsupported OS. Only Arch Linux, Ubuntu, and Windows (winget) are supported."
        exit 1
    fi
    print_status "Detected OS: $OS"
}

install_winget_packages() {
    print_status "Setting up winget sources..."
    winget source add -n winget -u https://cdn.winget.microsoft.com/cache 2>/dev/null || true
    winget source update --accept-source-agreements

    print_status "Installing packages via winget..."
    winget install --accept-package-agreements --accept-source-agreements \
        BurntSushi.ripgrep-Microsoft \
        sharkdp.fd \
        sharkdp.bat \
        eza-community.eza \
        ajeetdsouza.zoxide \
        junegunn.fzf \
        dandavison.delta \
        tldr \
        jesseduffield.lazygit \
        Atuinsh.Atuin \
        Starship.Starship \
        sxyazi.yazi

    print_success "Winget packages installed"
}

install_arch_packages() {
    print_status "Installing packages via pacman..."
    $SUDO pacman -Syu --noconfirm
    $SUDO pacman -S --noconfirm --needed \
        ripgrep \
        fd \
        bat \
        eza \
        zoxide \
        fzf \
        git-delta \
        tldr \
        lazygit \
        yazi \
        curl \
        starship \
        atuin \
        wget
    print_success "Arch packages installed"
}

# install_ubuntu_packages() {
#     print_status "Installing packages via apt..."
#     $SUDO apt update && $SUDO apt upgrade -y
#     $SUDO apt install -y \
#         ripgrep \
#         fd-find \
#         bat \
#         fzf \
#         curl \
#         wget
#
#     if ! command -v eza &> /dev/null; then
#         print_status "Installing eza from GitHub releases..."
#         EZA_VERSION=$(curl -s https://api.github.com/repos/eza-community/eza/releases/latest | grep tag_name | cut -d '"' -f 4)
#         wget -qO /tmp/eza.tar.gz "https://github.com/eza-community/eza/releases/download/${EZA_VERSION}/eza_x86_64-unknown-linux-gnu.tar.gz"
#         $SUDO tar -xzf /tmp/eza.tar.gz -C /usr/local/bin
#         rm /tmp/eza.tar.gz
#     fi
#
#     if ! command -v zoxide &> /dev/null; then
#         curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
#     fi
#
#     if ! command -v delta &> /dev/null; then
#         DELTA_VERSION=$(curl -s https://api.github.com/repos/dandavison/delta/releases/latest | grep tag_name | cut -d '"' -f 4)
#         wget -qO /tmp/delta.deb "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb"
#         $SUDO dpkg -i /tmp/delta.deb
#         rm /tmp/delta.deb
#     fi
#
#     if ! command -v tldr &> /dev/null; then
#         $SUDO apt install -y tldr || pip3 install --user tldr
#     fi
#
#     if ! command -v lazygit &> /dev/null; then
#         print_status "Installing lazygit from GitHub releases..."
#         LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep tag_name | cut -d '"' -f 4 | sed 's/^v//')
#         wget -qO /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
#         $SUDO tar -xzf /tmp/lazygit.tar.gz -C /usr/local/bin lazygit
#         rm /tmp/lazygit.tar.gz
#
#     fi
#
#     if ! command -v yazi &> /dev/null; then
#         print_status "Installing yazi from GitHub releases..."
#         YAZI_VERSION=$(curl -s https://api.github.com/repos/sxyazi/yazi/releases/latest | grep tag_name | cut -d '"' -f 4)
#         wget -qO /tmp/yazi.zip "https://github.com/sxyazi/yazi/releases/download/${YAZI_VERSION}/yazi-x86_64-unknown-linux-gnu.zip"
#         $SUDO unzip -o /tmp/yazi.zip -d /usr/local/bin
#         rm /tmp/yazi.zip
#     fi
#
#     [ -f /usr/bin/fdfind ] && $SUDO ln -sf /usr/bin/fdfind /usr/local/bin/fd 2>/dev/null || true
#     [ -f /usr/bin/batcat ] && $SUDO ln -sf /usr/bin/batcat /usr/local/bin/bat 2>/dev/null || true
#
#     print_success "Ubuntu packages installed"
# }

install_packages() {
    case $OS in
        windows) install_winget_packages ;;
        arch) install_arch_packages ;;
        ubuntu) install_ubuntu_packages ;;
    esac
}

configure_bashrc() {
    print_status "Configuring .bashrc..."

    [ -f "$HOME/.bashrc" ] && cp "$HOME/.bashrc" "$HOME/.bashrc.backup.$(date +%Y%m%d%H%M%S)"

    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local template="$script_dir/../.bashrc.template"

    if [[ -f "$template" ]]; then
        cp "$template" "$HOME/.bashrc"
        print_success ".bashrc configured from template"
    else
        print_error "Template not found at $template"
        return 1
    fi
}

configure_git() {
    print_status "Configuring Git with delta..."

    git config --global core.pager delta
    git config --global interactive.diffFilter "delta --color-only"
    git config --global delta.navigate true
    git config --global delta.side-by-side true
    git config --global delta.line-numbers true
    git config --global delta.syntax-theme "Catppuccin Mocha"
    git config --global delta.mouse true
    git config --global merge.conflictstyle diff3
    git config --global diff.colorMoved default

    print_success "Git configured with delta"

    cat << EOF > ~/.config/lazygit/config.yml
git:
  paging:
    colorArg: always
    pager: delta --dark --paging=never --line-numbers
EOF

    print_success "lazygit configured with delta"

    mkdir -p "$(bat --config-dir)/themes"
    cp "../themes/Catppuccin Mocha.tmTheme" "$(bat --config-dir)/themes"
    bat cache --build
    export BAT_THEME="Catppuccin Mocha"

    print_success "bat color configured"
}

main() {
    echo ""
    echo "=========================================="
    echo "   Modern CLI Tools Setup (Bash Only)"
    echo "=========================================="
    echo ""

    # detect_os
    # install_packages
    configure_bashrc
    configure_git

    echo ""
    echo "=========================================="
    print_success "Setup complete!"
    echo "=========================================="
    echo ""
    echo "Installed tools:"
    echo "  - ripgrep (rg)  : grep replacement"
    echo "  - fd            : find replacement"
    echo "  - bat           : cat replacement"
    echo "  - eza           : ls replacement"
echo "  - zoxide        : smarter cd"
echo "  - atuin         : command history"
echo "  - fzf           : fuzzy finder"
    echo "  - delta         : git diff enhancer"
    echo "  - tldr          : simplified man pages"
    echo "  - lazygit       : git TUI"
    echo "  - yazi          : file manager TUI"
    echo ""
    echo "Next steps:"
    echo "  1. Restart your terminal or run: exec bash"
    echo "  2. Install a Nerd Font for icons: https://www.nerdfonts.com/"
    echo ""
}

main "$@"
