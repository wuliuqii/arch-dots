#!/bin/sh
set -eu

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
BIN="$ROOT/bootstrap/proxy/sing-box"
CONF="$ROOT/bootstrap/proxy/config.bootstrap.json"

if [ ! -x "$BIN" ]; then
  echo "missing executable bootstrap proxy: $BIN" >&2
  echo "copy a sing-box binary there, or force-add one in a private repo." >&2
  exit 1
fi

if [ ! -f "$CONF" ]; then
  echo "missing bootstrap proxy config: $CONF" >&2
  echo "copy config.bootstrap.example.json to config.bootstrap.json and fill secrets." >&2
  exit 1
fi

sudo "$BIN" run -c "$CONF"

