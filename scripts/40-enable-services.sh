#!/bin/sh
set -eu

sudo systemctl enable --now NetworkManager systemd-resolved
sudo systemctl enable --now keyd greetd

if [ -f /etc/sing-box/config.json ]; then
  sudo systemctl enable --now sing-box
fi

systemctl --user enable --now dms.service
systemctl --user enable --now catppuccin-mode-sync.path

# niri 25.11 integrates xwayland-satellite. Keep the package, but do not
# run the standalone user service.
systemctl --user disable --now xwayland-satellite.service || true

