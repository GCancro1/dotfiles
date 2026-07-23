
# Update pacman and all packages first
# sudo pacman -Syu
# Make sure to reboot if updated anything
# sudo reboot

sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 10/' /etc/pacman.conf
sudo sed -i 's/#Color/Color/' /etc/pacman.conf
sudo sed -i 's/#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf

grep -E '^(ParallelDownloads|Color|VerbosePkgLists)' /etc/pacman.conf

sudo pacman -S reflector --noconfirm
sudo reflector --country 'United States' --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
sudo systemctl enable --now reflector.timer

#printer setup
sudo pacman -S cups cups-pdf system-config-printer --noconfirm
sudo systemctl enable --now cups
sudo pacman -S avahi nss-mdns --noconfirm
sudo systemctl enable --now avahi-daemon

#firewall
sudo pacman -S ufw --noconfirm
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable
sudo systemctl enable ufw
sudo ufw status verbose

#ssd trim
sudo systemctl enable --now fstrim.timer
systemctl status fstrim.timer


#snapshots
yay -S timeshift


#video needs
sudo pacman -S gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav ffmpeg --noconfirm

#laptop power settings
sudo pacman -S tlp tlp-rdw --noconfirm
sudo systemctl enable --now tlp
sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
sudo tlp-stat -b

# echo "kernel.kptr_restrict = 2
# net.core.bpf_jit_harden = 2
# kernel.yama.ptrace_scope = 1
# net.ipv4.conf.all.rp_filter = 1
# net.ipv4.conf.default.rp_filter = 1" > /etc/sysctl.d/99-security.conf

# zram 
sudo pacman -S zram-generator

# sudo nvim /etc/systemd/zram-generator.conf
# [zram0]
# zram-size = ram / 2
# compression-algorithm = zstd
