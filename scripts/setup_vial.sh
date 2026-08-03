#!/bin/bash
set -e

UDEV_RULE="/etc/udev/rules.d/59-vial.rules"
RULE_CONTENT='KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"'

echo "=== Vial Setup Script ==="

# Create udev rule
if [ -f "$UDEV_RULE" ]; then
    echo "Udev rule already exists at $UDEV_RULE, skipping creation."
else
    echo "Creating udev rule at $UDEV_RULE..."
    echo "$RULE_CONTENT" | sudo tee "$UDEV_RULE" > /dev/null
    echo "Udev rule created."
fi

# Reload and trigger udev rules
echo "Reloading udev rules..."
sudo udevadm control --reload-rules
sudo udevadm trigger
echo "Udev rules reloaded and triggered."

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Important: You must log out and log back in for the group change to take effect."
echo ""
echo "Also, enable the following Chrome flag for WebHID support:"
echo "  chrome://flags/#enable-experimental-web-platform-features"
echo ""
echo "IMPORTANT: After enabling the flag, fully quit Chrome (close all windows and"
echo "ensure the process is completely stopped) then restart it. Simply reloading"
echo "the page is NOT enough — the WebHID feature flag only takes effect on a full restart."
