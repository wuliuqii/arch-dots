#!/bin/sh
set -eu

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

grep -Ev '^\s*($|#)' "$ROOT/packages/pacman.txt" | xargs -r sudo pacman -Syu --needed --

if ! command -v paru >/dev/null 2>&1; then
  echo "paru not found. Run bootstrap/scripts/02-install-paru.sh first." >&2
  exit 1
fi

grep -Ev '^\s*($|#)' "$ROOT/packages/aur.txt" | xargs -r paru -S --needed --
