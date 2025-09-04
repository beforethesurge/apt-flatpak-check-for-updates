#!/bin/sh

# New line to separate from other entries in potential log file
echo
# Outputs date for auditing
date

echo "🔍 Checking for apt updates..."
apt update

packages_to_update=$(apt list --upgradable 2>/dev/null | grep -v "Listing..." | wc -l)
if [ "$packages_to_update" -eq 0 ]; then
    echo "✅ Apt is up-to-date"
else
    echo "📦 Apt has $packages_to_update packages that can be upgraded"
    echo "🚀 Upgrading packages..."
    apt upgrade -y
fi

echo
echo "🧹 Checking for apt packages no longer being used..."
packages_to_remove_check=$(apt autoremove --dry-run 2>/dev/null | grep -E '^Remv' | wc -l)

if [ "$packages_to_remove_check" -eq 0 ]; then
    echo "✅ No packages to remove!"
else
    echo "🗑️ Apt has $packages_to_remove_check unused packages found"
    echo "🧼 Removing unused packages..."
    apt autoremove --purge -y
fi

# Checks if Flatpak is installed and has updates available
echo
if command -v flatpak >/dev/null 2>&1; then
    echo "Flatpak is installed"
    flatpak_check_for_updates=$(flatpak update --appstream -y --noninteractive 2>&1 | grep -E 'Updates available|Nothing to do')
    if echo "$flatpak_check_for_updates" | grep -q "Updates available"; then
        echo "📦 Flatpak updates found. Downloading and installing updates..."
        flatpak update -y
    elif echo "$flatpak_check_for_updates" | grep -q "Nothing to do"; then
        echo "✅ No Flatpak updates found"
    else
        echo "⚠️ Unexpected output while checking for updates:"
        echo "$updates"
    fi
else
    echo "❌ Flatpak is not installed; Skipping"
fi
