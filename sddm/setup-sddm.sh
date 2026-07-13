#!/usr/bin/env bash
# Setup SDDM with selected theme
set -euo pipefail

THEME="${1:-simple-sddm-2}"

if [[ "$THEME" == "none" ]]; then
  echo "SDDM theme setup skipped."
  exit 0
fi

SDDM_CONF="/etc/sddm.conf.d/10-qsdots-sddm-override.conf"

case "$THEME" in
  caelestia-locklike|caelestia)
    CURRENT="caelestia-locklike"
    ;;
  simple-sddm-2|simple|jakoolit)
    CURRENT="simple-sddm-2"
    ;;
  *)
    echo "Unknown theme: $THEME"
    echo "Available: caelestia-locklike, simple-sddm-2"
    exit 1
    ;;
esac

# Create config
sudo mkdir -p /etc/sddm.conf.d
sudo tee "$SDDM_CONF" > /dev/null <<EOF
[Theme]
Current=$CURRENT
EOF

# Enable SDDM
sudo systemctl enable sddm 2>/dev/null || true

echo "SDDM theme set to: $CURRENT"
echo "Config written to: $SDDM_CONF"
