#!/usr/bin/env bash
set -euo pipefail

session_file="${XDG_STATE_HOME:-$HOME/.local/state}/DankMaterialShell/session.json"
settings_file="${XDG_CONFIG_HOME:-$HOME/.config}/DankMaterialShell/settings.json"

update_json_flag() {
  local file="$1"
  local key="$2"
  local value="$3"

  [[ -f "$file" ]] || return 0

  python - "$file" "$key" "$value" <<'PY'
import json
import sys
from pathlib import Path

path = Path(sys.argv[1])
key = sys.argv[2]
value = sys.argv[3].lower() == "true"

data = json.loads(path.read_text())
if data.get(key) is value:
    raise SystemExit(0)

data[key] = value
path.write_text(json.dumps(data, indent=2) + "\n")
print("changed")
PY
}

changed=0

if [[ "$(update_json_flag "$session_file" "themeModeAutoEnabled" "false")" == "changed" ]]; then
  changed=1
fi

if [[ "$(update_json_flag "$settings_file" "syncModeWithPortal" "false")" == "changed" ]]; then
  changed=1
fi

if [[ $changed -eq 1 ]] && systemctl --user --quiet is-active dms.service 2>/dev/null; then
  systemctl --user restart dms.service
fi
