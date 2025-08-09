#!/bin/bash

echo "Checking for updates..."
sudo apt update

packages_to_update=$(apt list --upgradeable | grep -o -E '\w+/\w+')
if [[ -n "$packages_to_update" ]]; then
    echo "The following updates are available:"
    echo "$packages_to_update"
    read -p "Apply? (y/n): " user_apply_updates
    user_apply_updates=$(echo "$user_apply_updates" | tr "[:upper:]" "[:lower:]")
    if [[ "$user_apply_updates" == "y" ]]; then
        echo "Applying updates..."
        sudo apt full-upgrade -y
        echo "Updates applied successfully!"
    else
        echo "Updates skipped"
    fi
else
    echo "No updates found"
fi

echo "Checking for packages no longer being used..."
packages_to_remove_check=$(apt autoremove --dry-run | grep -o -E '\w+/\w+')

if [[ -n "$packages_to_remove_check" ]]; then
    read -p "Packages found. Remove them? (y/n): " user_remove_packages
    user_remove_packages=$(echo "$user_remove_packages" | tr "[:upper:]" "[:lower:]")
    if [[ "$user_remove_packages" == "y" ]]; then
        echo "Removing packages..."
        sudo apt autoremove -y
        echo "Packages removed successfully!"
    else
        echo "Packages skipped"
    fi
else
    echo "No packages found"
fi