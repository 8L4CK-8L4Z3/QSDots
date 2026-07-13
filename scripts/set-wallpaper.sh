#!/usr/bin/env bash
# set-wallpaper.sh — canonical script
# Set wallpaper via swww and regenerate matugen theme
set -euo pipefail

WALLPAPER="${1:-}"
WALL_DIR="${WALL_DIR:-$HOME/Pictures/Wallpapers}"

if [[ -z "$WALLPAPER" ]]; then
  echo "Usage: $0 <path-to-image>"
  echo "Pick from: $WALL_DIR"
  ls "$WALL_DIR" 2>/dev/null || echo "(no wallpapers found)"
  exit 1
fi

if [[ ! -f "$WALLPAPER" ]]; then
  echo "File not found: $WALLPAPER"
  exit 1
fi

swww img "$WALLPAPER" --transition-type wipe --transition-duration 1

if command -v matugen &>/dev/null; then
  matugen image "$WALLPAPER" --type scheme-tonal-spot
  echo "Theme regenerated via matugen"
fi

echo "$WALLPAPER" > "$HOME/.cache/last-wallpaper"

notify-send "Wallpaper set" "$(basename "$WALLPAPER")"
