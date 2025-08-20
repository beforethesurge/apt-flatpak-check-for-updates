#!/bin/sh

echo "🔍 Checking for updates..."
apt update

packages_to_update=$(apt list --upgradable 2>/dev/null | grep -v "Listing..." | wc -l)
if [ "$packages_to_update" -eq 0 ]; then
    echo "✅ Your system is already up to date"
else
    echo "📦 $packages_to_update packages can be upgraded"
    echo "🚀 Upgrading packages..."
    apt upgrade -y
fi

echo "🧹 Checking for packages no longer being used..."
packages_to_remove_check=$(apt autoremove --dry-run 2>/dev/null | grep -E '^Remv' | wc -l)

if [ "$packages_to_remove_check" -eq 0 ]; then
    echo "✅ No packages to remove!"
else
    echo "🗑️ $packages_to_remove_check unused packages found"
    echo "🧼 Removing unused packages..."
    apt autoremove --purge -y
fi
