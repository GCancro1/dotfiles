echo 'KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"' | sudo tee /etc/udev/rules.d/99-vial.rules

sudo udevadm control --reload && sudo udevadm trigger


sudo setfacl -m "u:${USER}:rw" /dev/hidraw3
sudo udevadm control --reload-rules && sudo udevadm trigger

sudo chmod 0666 /dev/hidraw1
