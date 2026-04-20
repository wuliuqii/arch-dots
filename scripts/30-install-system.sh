#!/bin/sh
set -eu

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

sudo install -Dm644 "$ROOT/system/etc/keyd/default.conf" /etc/keyd/default.conf
sudo install -Dm644 "$ROOT/system/etc/greetd/config.toml" /etc/greetd/config.toml

if [ -f "$HOME/.config/sing-box/config.json" ]; then
  sudo install -Dm600 "$HOME/.config/sing-box/config.json" /etc/sing-box/config.json
else
  echo "missing ~/.config/sing-box/config.json; decrypt or create it before enabling sing-box" >&2
fi

