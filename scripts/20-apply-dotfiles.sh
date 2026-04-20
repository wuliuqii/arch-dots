#!/bin/sh
set -eu

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
chezmoi init --source "$ROOT/chezmoi"
chezmoi apply

