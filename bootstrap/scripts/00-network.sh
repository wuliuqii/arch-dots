#!/bin/sh
set -eu

sudo pacman -Syu --needed git base-devel curl chezmoi networkmanager
sudo systemctl enable --now NetworkManager systemd-resolved

echo "If Wi-Fi is not connected, use:"
echo "  nmcli device wifi list"
echo "  nmcli device wifi connect SSID password PASSWORD"
