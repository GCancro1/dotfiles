#!/bin/bash
# Love2D game development environment setup
# Installs Love2D engine + Lua dev tools

set -euo pipefail

echo "=== Installing Love2D ==="
sudo pacman -S --needed --noconfirm \
  love \
  luarocks \
  lua51 \
  stylua \
  luacheck

echo ""
echo "=== Installing Love2D API definitions ==="
LOVE_API_DIR="$HOME/.local/share/love-api"
if [ -d "$LOVE_API_DIR/.git" ]; then
  echo "Love2D API repo found, updating..."
  if git -C "$LOVE_API_DIR" pull --ff-only; then
    echo "Love2D API updated."
  else
    echo "Warning: 'git pull --ff-only' failed, continuing anyway."
  fi
elif [ -d "$LOVE_API_DIR" ]; then
  echo "Note: $LOVE_API_DIR exists but is not a git repo. Skipping install (not overwriting)."
else
  echo "Cloning EmmyLua Love2D API definitions..."
  if git clone --depth 1 https://github.com/EmmyLua/Emmy-love-api "$LOVE_API_DIR"; then
    echo "Love2D API cloned."
  else
    echo "Error: clone failed. Install manually with:"
    echo "  git clone https://github.com/EmmyLua/Emmy-love-api ~/.local/share/love-api"
  fi
fi

if [ -f "$LOVE_API_DIR/api/love.graphics.lua" ]; then
  echo "Love2D API verified: $LOVE_API_DIR/api/love.graphics.lua"
else
  echo "Error: Love2D API verification failed (api/love.graphics.lua not found)."
fi

echo ""
echo "=== Verifying installation ==="
love --version
stylua --version
luacheck --version

echo ""
echo "Done! Run 'love .' in a project directory to test."
echo "Note: lua-language-server is managed by Mason in Neovim."
echo "Note: restart lua_ls in nvim with ':LspRestart lua_ls' (or restart nvim) after installing."
