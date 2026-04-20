#!/bin/sh
set -eu

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
IDENTITY="${ARCH_DOTS_AGE_IDENTITY:-$HOME/.config/age/arch-dots-key.txt}"

if ! command -v age >/dev/null 2>&1; then
  echo "missing age command; install package: sudo pacman -S age" >&2
  exit 1
fi

if [ ! -f "$IDENTITY" ]; then
  echo "missing age identity: $IDENTITY" >&2
  echo "set ARCH_DOTS_AGE_IDENTITY=/path/to/key.txt or restore ~/.config/age/arch-dots-key.txt" >&2
  exit 1
fi

restore_secret() {
  src="$1"
  dst="$2"
  mode="$3"

  if [ ! -f "$ROOT/secrets/$src" ]; then
    echo "skip missing secret: $src"
    return 0
  fi

  mkdir -p "$(dirname "$dst")"
  age -d -i "$IDENTITY" "$ROOT/secrets/$src" > "$dst"
  chmod "$mode" "$dst"
  echo "restored $dst"
}

restore_secret sing-box-config.age "$HOME/.config/sing-box/config.json" 600
restore_secret ssh-id_ed25519.age "$HOME/.ssh/id_ed25519" 600
restore_secret cc-switch-db.age "$HOME/.cc-switch/cc-switch.db" 600
restore_secret cc-switch-settings.age "$HOME/.cc-switch/settings.json" 600

