#!/usr/bin/env bash
# set-wallpaper.sh — canonical script
# Set wallpaper via swww and regenerate full theme
set -euo pipefail

WALLPAPER="${1:-}"
WALL_DIR="${WALL_DIR:-$HOME/Pictures/Wallpapers}"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

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

# Set wallpaper with swww
swww img "$WALLPAPER" --transition-type wipe --transition-duration 1

# Regenerate matugen theme
if command -v matugen &>/dev/null; then
  # Quickshell palette
  matugen image "$WALLPAPER" \
    --type scheme-tonal-spot \
    --template qs-palette \
    --output "$CONFIG_DIR/quickshell/theme.json" 2>/dev/null || \
  matugen image "$WALLPAPER" \
    --type scheme-tonal-spot \
    -o "$CONFIG_DIR/quickshell/theme.json" 2>/dev/null || true

  # GTK theme (matugen built-in or via template)
  if [[ -f "$CONFIG_DIR/matugen/templates/qs-gtk.css" ]]; then
    matugen image "$WALLPAPER" --type scheme-tonal-spot \
      --template qs-gtk \
      --output "$CONFIG_DIR/gtk-3.0/gtk.css" 2>/dev/null || true
    cp "$CONFIG_DIR/gtk-3.0/gtk.css" "$CONFIG_DIR/gtk-4.0/gtk.css" 2>/dev/null || true
  fi

  # Kvantum theme
  if command -v kvantummanager &>/dev/null; then
    matugen image "$WALLPAPER" --type scheme-tonal-spot \
      --target kvantum \
      -o "$CONFIG_DIR/Kvantum/qs-dotfiles/" 2>/dev/null || true
  fi

  echo "Theme regenerated via matugen"
fi

# Write last wallpaper for persistence
echo "$WALLPAPER" > "$HOME/.cache/last-wallpaper"

# Notify
notify-send "Wallpaper set" "$(basename "$WALLPAPER")"
