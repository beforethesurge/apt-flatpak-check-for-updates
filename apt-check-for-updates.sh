#!/bin/bash

echo "Checking for updates..."
sudo apt-get update

packages_to_update=$(apt list --upgradeable | grep "*-*")
if [[ -n "$packages_to_update" ]]; then
    echo "The following updates are available:"
    echo "$packages_to_update"
    read -p "Apply? (Y/n): " user_apply_updates
    user_apply_updates=$(echo "$user_apply_updates" | tr "[:upper:]" "[:lower:]")
    if [[ "$user_apply_updates" == "y" || "$user_apply_updates" == "" ]]; then
        echo "Applying updates..."
        sudo apt-get upgrade -y
        echo "Updates applied successfully!"
    else
        echo "Updates skipped"
    fi
else
    echo "No updates found"
fi

echo "Checking for packages no longer being used..."
packages_to_remove_check=$(apt autoremove --dry-run | grep "*-*")

if [[ -n "$packages_to_remove_check" ]]; then
    read -p "Packages found. Remove them? (Y/n): " user_remove_packages
    user_remove_packages=$(echo "$user_remove_packages" | tr "[:upper:]" "[:lower:]")
    if [[ "$user_remove_packages" == "y" || "$user_remove_packages" == "" ]]; then
        echo "Removing packages..."
        sudo apt-get autoremove -y
        echo "Packages removed successfully!"
    else
        echo "Packages skipped"
    fi
else
    echo "No packages found"
fi
