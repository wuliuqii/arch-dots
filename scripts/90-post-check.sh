#!/bin/sh
set -eu

echo "== packages =="
command -v niri
command -v foot
command -v fcitx5
command -v sing-box
command -v nvim
command -v rg
command -v fish
command -v zoxide
command -v starship
command -v gh
command -v codex || true
command -v cc-switch || true

echo "== fcitx =="
fcitx5-remote -n || true

echo "== services =="
systemctl is-enabled keyd greetd sing-box || true
systemctl --user is-enabled dms.service catppuccin-mode-sync.path xwayland-satellite.service || true

echo "== sing-box =="
if [ -f "$HOME/.config/sing-box/config.json" ]; then
  sing-box check -c "$HOME/.config/sing-box/config.json"
fi
