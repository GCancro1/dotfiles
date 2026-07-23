sudo pacman -S dkms linux-headers
yay -S displaylink
sudo systemctl enable --now displaylink.service
sudo modprobe evdi
