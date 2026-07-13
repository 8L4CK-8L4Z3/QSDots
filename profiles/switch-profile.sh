#!/usr/bin/env bash
# switch-profile.sh — switch between profile sets
# Usage: switch-profile.sh <profile_name>

set -euo pipefail

PROFILE_DIR="$HOME/.config/profiles"
PROFILE_FILE="$PROFILE_DIR/current"
PROFILE_NAME="${1:-}"

if [[ -z "$PROFILE_NAME" ]]; then
  echo "Usage: $0 <profile_name>"
  echo "Available:"
  ls "$PROFILE_DIR/" 2>/dev/null || echo "  (no profiles installed)"
  exit 1
fi

if [[ ! -d "$PROFILE_DIR/$PROFILE_NAME" ]]; then
  echo "Profile '$PROFILE_NAME' not found in $PROFILE_DIR"
  exit 1
fi

# Write current profile
mkdir -p "$PROFILE_DIR"
echo "$PROFILE_NAME" > "$PROFILE_FILE"

# Apply profile-specific overrides
if [[ -f "$PROFILE_DIR/$PROFILE_NAME/apply.sh" ]]; then
  bash "$PROFILE_DIR/$PROFILE_NAME/apply.sh"
fi

# Restart Quickshell to apply visual changes
pkill -x qs 2>/dev/null || true
sleep 0.3
qs &

notify-send "Profile" "Switched to: $PROFILE_NAME"
echo "Profile switched to: $PROFILE_NAME"
