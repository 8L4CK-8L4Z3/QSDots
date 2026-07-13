#!/usr/bin/env bash
# Pick a random wallpaper and apply it
WALL_DIR="${WALL_DIR:-$HOME/Pictures/Wallpapers}"
if [[ ! -d "$WALL_DIR" ]]; then
  notify-send "Wallpaper" "No wallpapers in $WALL_DIR"
  exit 1
fi
MAPFILE=( "$WALL_DIR"/*.{jpg,jpeg,png,bmp,gif} 2>/dev/null )
if [[ ${#MAPFILE[@]} -eq 0 ]]; then
  notify-send "Wallpaper" "No images found in $WALL_DIR"
  exit 1
fi
RANDOM_IMG="${MAPFILE[RANDOM % ${#MAPFILE[@]}]}"
exec "$HOME/.config/scripts/set-wallpaper.sh" "$RANDOM_IMG"
