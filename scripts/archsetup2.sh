#!/usr/bin/env bash
set -e

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm \
    hyprland \
    kitty \
    firefox \
    network-manager-applet \
    hyprpolkitagent \
    xdg-desktop-portal \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal-gtk \
    qt5-wayland \
    qt6-wayland \
    mako \
    cliphist \
    wl-clipboard \
    thunar \
    waybar \
    wofi

sudo pacman -S ttf-jetbrains-mono-nerd ttf-font-awesome noto-fonts --noconfirm
sudo pacman -S --needed base-devel git --noconfirm

if [ -d "yay" ]; then
  echo "yay directory already exists. Entering it instead of cloning."
  cd yay
else
  git clone https://aur.archlinux.org/yay.git
  cd yay
fi

makepkg -si
yay -S google-chrome zen-browser-bin
cd ..
sudo systemctl enable --now NetworkManager

mkdir -p ~/.config/hypr

cp ~/.config/hypr/hyprland.lua ~/.config/hypr/hyprland.lua.bak.$(date +%s)
#
# python <<'PY'
# from pathlib import Path
#
# p = Path.home() / ".config/hypr/hyprland.lua"
# txt = p.read_text()
#
# marker = "-- Autostart necessary processes"
#
# block = '''
# hl.on("hyprland.start", function()
#
#     hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
#
#     hl.exec_cmd("hyprpolkitagent")
#     hl.exec_cmd("mako")
#     hl.exec_cmd("nm-applet --indicator")
#     hl.exec_cmd("waybar")
#
#     hl.exec_cmd("wl-paste --type text --watch cliphist store")
#     hl.exec_cmd("wl-paste --type image --watch cliphist store")
#
# end)
# '''
#
# if "hyprpolkitagent" not in txt:
#     txt = txt.replace(marker, marker + "\n" + block)
#
# p.write_text(txt)
# PY
sudo pacman -S sddm
sudo systemctl enable sddm
sudo systemctl start sddm


echo
echo "Done."
echo "Logout and log back in."
