#!/usr/bin/env bash
set -euo pipefail

# OpenCode Multi-Agent Setup Script
# Installs plugins for running multiple agents with git worktrees
# Usage: ./setup.sh [--global]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL=false

if [[ "${1:-}" == "--global" ]]; then
    GLOBAL=true
fi

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[opencode-setup]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[opencode-setup]${NC} $1"
}

error() {
    echo -e "${RED}[opencode-setup]${NC} $1" >&2
    exit 1
}

# Check dependencies
check_deps() {
    log "Checking dependencies..."
    
    if ! command -v opencode &>/dev/null; then
        error "opencode not found. Install: curl -fsSL https://opencode.ai/install | bash"
    fi
    
    if ! command -v ocx &>/dev/null; then
        warn "ocx not found. Installing..."
        curl -fsSL https://ocx.kdco.dev/install.sh | sh
    fi
    
    if ! command -v node &>/dev/null; then
        error "node not found. Install nodejs"
    fi
}

# Install OCX plugins
install_plugins() {
    log "Installing opencode plugins..."
    
    OCX_FLAGS=""
    if [[ "$GLOBAL" == true ]]; then
        OCX_FLAGS="--global"
    fi
    
    # Initialize ocx config if needed
    OCX_CONF="$HOME/.config/opencode/ocx.jsonc"
    if [[ "$GLOBAL" == false ]]; then
        OCX_CONF="$SCRIPT_DIR/.opencode/ocx.jsonc"
    fi
    if [[ ! -f "$OCX_CONF" ]]; then
        log "Initializing ocx..."
        if [[ "$GLOBAL" == true ]]; then
            ocx init --global -q || warn "Failed to initialize ocx"
        else
            ocx init --cwd "$SCRIPT_DIR" -q || warn "Failed to initialize ocx"
        fi
    fi
    
    # Core workspace bundle (includes worktree, background-agents, workspace-plugin, notify)
    log "Installing workspace bundle..."
    ocx add kdco/workspace --from https://registry.kdco.dev $OCX_FLAGS || warn "Failed to install workspace bundle"
    
    log "Plugin installation complete"
}

# Install shell-strategy plugin
install_shell_strategy() {
    log "Installing shell-strategy plugin..."
    
    PLUGIN_DIR="$SCRIPT_DIR/.opencode/plugins/shell-strategy"
    if [[ ! -d "$PLUGIN_DIR" ]]; then
        mkdir -p "$SCRIPT_DIR/.opencode/plugins"
        if git clone --depth 1 https://github.com/JRedeker/opencode-shell-strategy.git "$PLUGIN_DIR"; then
            log "shell-strategy plugin cloned"
        else
            error "Failed to clone shell-strategy plugin. Check your network and try again."
        fi
    else
        warn "shell-strategy plugin already exists, skipping"
    fi
}

# Install opencode-diff plugin
install_opencode_diff() {
    log "Installing opencode-diff plugin..."
    
    # Install via npm (op setup --global is the official way, but npm works too)
    if command -v npm &>/dev/null; then
        npm install -g opencode-diff || warn "Failed to install opencode-diff globally via npm"
    fi
    
    # Copy diff-plugin.json to project .opencode/ directory if it doesn't exist
    DIFF_CONF="$SCRIPT_DIR/.opencode/diff-plugin.json"
    if [[ ! -f "$DIFF_CONF" ]]; then
        cp "$SCRIPT_DIR/diff-plugin.json" "$DIFF_CONF" 2>/dev/null || warn "diff-plugin.json not found in opencode config dir"
        log "Copied diff-plugin.json to .opencode/"
    else
        warn "diff-plugin.json already exists in .opencode/, skipping"
    fi
}

# Install .opencode npm dependencies
install_opencode_deps() {
    log "Installing .opencode npm dependencies..."
    
    if [[ ! -d "$SCRIPT_DIR/.opencode" ]]; then
        warn ".opencode directory not found, skipping npm install"
        return
    fi
    cd "$SCRIPT_DIR/.opencode"
    
    if [[ -f package.json ]]; then
        npm install
        log ".opencode npm dependencies installed"
    else
        warn "No .opencode/package.json found, skipping"
    fi
}

# Create worktree config if it doesn't exist
create_worktree_config() {
    WORKTREE_CONFIG="$SCRIPT_DIR/worktree.jsonc"
    
    if [[ ! -f "$WORKTREE_CONFIG" ]]; then
        log "Creating worktree.jsonc..."
        cat > "$WORKTREE_CONFIG" << 'EOF'
{
  "$schema": "https://registry.kdco.dev/schemas/worktree.json",
  "sync": {
    "copyFiles": [".env", ".env.local"],
    "symlinkDirs": ["node_modules"],
    "exclude": [".git", "dist", "build", ".next"]
  },
  "hooks": {
    "postCreate": [],
    "preDelete": []
  }
}
EOF
        log "Created worktree.jsonc"
    fi
}

# Create delegation storage directory
create_delegation_dir() {
    DELEGATION_DIR="$HOME/.local/share/opencode/delegations"
    if [[ ! -d "$DELEGATION_DIR" ]]; then
        mkdir -p "$DELEGATION_DIR"
        log "Created delegation storage directory"
    fi
}

# Print usage
print_usage() {
    cat << 'EOF'
OpenCode Multi-Agent Setup

Usage:
  ./setup.sh              Install plugins for current user
  ./setup.sh --global     Install plugins globally

This installs:
  - kdco/workspace: Multi-agent orchestration bundle
  - opencode-diff: Interactive diff review for file edits

After installation:
  1. Restart opencode
  2. Use worktree_create() to spawn isolated worktrees
  3. Use delegate() to run background tasks

Worktree usage:
  - worktree_create("feature-name") - Creates isolated worktree
  - worktree_delete("reason") - Cleans up worktree

Background agents:
  - delegate("research task", "researcher") - Run async research
  - delegation_list() - List all delegations
  - delegation_read(id) - Get specific result

Configuration files:
  - ~/.config/opencode/opencode.jsonc - Main config
  - ~/.config/opencode/worktree.jsonc - Worktree settings
  - ~/.config/opencode/diff-plugin.json - Diff plugin settings
  - ~/.config/opencode/agents/ - Custom agent definitions
EOF
}

# Main
main() {
    case "${1:-}" in
        -h|--help)
            print_usage
            exit 0
            ;;
        *)
            check_deps
            install_plugins
            install_shell_strategy
            install_opencode_deps
            install_opencode_diff
            create_worktree_config
            create_delegation_dir
            log "Setup complete! Restart opencode to use new plugins."
            print_usage
            ;;
    esac
}

main "$@"
