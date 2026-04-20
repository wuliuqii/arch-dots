#!/bin/sh
set -eu

export http_proxy="${http_proxy:-http://127.0.0.1:7890}"
export https_proxy="${https_proxy:-http://127.0.0.1:7890}"
export all_proxy="${all_proxy:-socks5://127.0.0.1:7890}"
export CARGO_NET_GIT_FETCH_WITH_CLI="${CARGO_NET_GIT_FETCH_WITH_CLI:-true}"

if command -v paru >/dev/null 2>&1; then
  echo "paru already installed"
  exit 0
fi

rm -rf /tmp/paru
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru
makepkg -si

