#!/usr/bin/env bash
set -euo pipefail

session_file="${XDG_STATE_HOME:-$HOME/.local/state}/DankMaterialShell/session.json"
wallpaper_dir="${XDG_DATA_HOME:-$HOME/.local/share}/wallpapers/Catppuccin"
light_wallpaper="$wallpaper_dir/clear-day.jpg"
dark_wallpaper="$wallpaper_dir/clear-night.jpg"

[[ -f "$session_file" ]] || exit 0
[[ -f "$light_wallpaper" ]] || exit 0
[[ -f "$dark_wallpaper" ]] || exit 0

changed="$(
python - "$session_file" "$light_wallpaper" "$dark_wallpaper" <<'PY'
import json
import sys
from pathlib import Path

path = Path(sys.argv[1])
light = sys.argv[2]
dark = sys.argv[3]

data = json.loads(path.read_text())
orig = json.dumps(data, sort_keys=True)

data["perModeWallpaper"] = True
data["wallpaperPathLight"] = light
data["wallpaperPathDark"] = dark
data["wallpaperPath"] = light if data.get("isLightMode", False) else dark

new = json.dumps(data, sort_keys=True)
if new == orig:
    print("unchanged")
else:
    path.write_text(json.dumps(data, indent=2) + "\n")
    print("changed")
PY
)"

if [[ "$changed" == "changed" ]] && systemctl --user --quiet is-active dms.service 2>/dev/null; then
  systemctl --user restart dms.service
fi
