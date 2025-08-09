#!/bin/bash

echo "Checking for updates..."
sudo apt update

echo "The following updates are available:"
apt list --upgradeable

read -p "Apply? (y/n): " user_apply_updates
if [[ "$user_apply_updates" == "y" ]]; then
    echo "Applying updates..."
    sudo apt full-upgrade -y
    echo "Updates applied successfully!"
else
    echo "Updates skipped"
fi

echo "Checking for packages no longer being used..."
apt autoremove --dry-run | grep -o -E '\w+/\w+'

read -p "Remove these packages? (y/n): " user_remove_packages
if [[ "$user_remove_packages" == "y" ]]; then
    echo "Removing packages..."
    sudo apt autoremove -y
    echo "Packages removed successfully!"
else
    echo "No packages removed"
fi