#!/usr/bin/env bash
# theme-gen.sh — regenerate theme from the last wallpaper
# Useful after a system restart to reapply theming without changing wallpaper
set -euo pipefail

LAST_WALL="$HOME/.cache/last-wallpaper"

if [[ ! -f "$LAST_WALL" ]]; then
  echo "No last wallpaper found. Run set-wallpaper.sh first."
  exit 1
fi

WALLPAPER="$(cat "$LAST_WALL")"
if [[ ! -f "$WALLPAPER" ]]; then
  echo "Last wallpaper not found: $WALLPAPER"
  exit 1
fi

exec "$HOME/.config/scripts/set-wallpaper.sh" "$WALLPAPER"
