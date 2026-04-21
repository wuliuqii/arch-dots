#!/usr/bin/env bash
set -euo pipefail

if pgrep -f '(/opt/google/chrome/chrome|/usr/lib/chromium/chromium)' >/dev/null 2>&1; then
  echo "Chrome/Chromium is running; skip browser font preference patch."
  echo "Close Chrome and rerun: chezmoi apply"
  exit 0
fi

python <<'PY'
import json
from pathlib import Path

home = Path.home()
roots = [
    home / ".config" / "google-chrome",
    home / ".config" / "chromium",
]

font_map = {
    "standard": "Noto Sans CJK SC",
    "serif": "Noto Serif CJK SC",
    "sansserif": "Noto Sans CJK SC",
    "fixed": "Sarasa Mono SC",
}

scripts = ("Zyyy", "Hans")

for root in roots:
    if not root.is_dir():
        continue

    for prefs in root.glob("*/Preferences"):
        try:
            data = json.loads(prefs.read_text())
        except Exception as exc:
            print(f"skip unreadable preferences: {prefs}: {exc}")
            continue

        fonts = data.setdefault("webkit", {}).setdefault("webprefs", {}).setdefault("fonts", {})
        changed = False

        for generic_family, font_name in font_map.items():
            family_settings = fonts.setdefault(generic_family, {})
            for script in scripts:
                if family_settings.get(script) != font_name:
                    family_settings[script] = font_name
                    changed = True

        if changed:
            prefs.write_text(json.dumps(data, separators=(",", ":"), ensure_ascii=False) + "\n")
            print(f"updated browser font preferences: {prefs}")
PY
