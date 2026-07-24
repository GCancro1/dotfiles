#!/usr/bin/env bash
# ============================================
# Pacman Speed Optimization
# ============================================
# Safe to run on any Arch/CachyOS install.
# Enables parallel downloads, color output, and sorts mirrors by speed.

set -e

echo "=== Pacman Speed Optimization ==="

# Enable parallel downloads, color, and verbose package lists
sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 10/' /etc/pacman.conf
sudo sed -i 's/#Color/Color/' /etc/pacman.conf
sudo sed -i 's/#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf

echo "  pacman.conf updated:"
grep -E '^(ParallelDownloads|Color|VerbosePkgLists)' /etc/pacman.conf

# Optimize mirrors by speed
if command -v reflector &> /dev/null; then
    echo "  Sorting mirrors by speed..."
    sudo reflector --country 'United States' --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
else
    echo "  reflector not installed, skipping mirror optimization"
    echo "  Install with: sudo pacman -S reflector"
fi

echo ""
echo "Done! Package installs will now be faster."
