#!/usr/bin/env bash
# QSDotfiles — opt-in installer
# CORE always installed. Optional groups prompted interactively.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

# ── Bootstrap yay ──────────────────────────────────────────────────────────
if ! command -v yay &>/dev/null; then
  echo "yay not found — bootstrapping from AUR..."
  sudo pacman -S --needed --noconfirm base-devel git go
  git clone https://aur.archlinux.org/yay.git /tmp/yay-bootstrap
  (cd /tmp/yay-bootstrap && makepkg -si --noconfirm)
  rm -rf /tmp/yay-bootstrap
  echo "yay installed."
fi
AUR="yay"
echo "Using package manager: $AUR"

# ── Parse packages.txt ─────────────────────────────────────────────────
unset GROUPS
declare -A GROUPS
GROUP=""
while IFS= read -r line; do
  line="${line%%#*}"
  line="${line## }"
  line="${line%% }"
  [[ -z "$line" ]] && continue
  if [[ "$line" =~ ^\[(.*)\]$ ]]; then
    GROUP="${BASH_REMATCH[1]}"
    continue
  fi
  GROUPS["$GROUP"]+="$line "
done < packages.txt

install_pkgs() {
  local pkgs="$1"
  [[ -z "$pkgs" ]] && return
  echo "  → Installing: $pkgs"
  yay -S --needed --noconfirm $pkgs 2>/dev/null || true
}

prompt_yn() {
  local prompt="$1"
  local default="${2:-y}"
  local ans
  read -rp "$prompt [${default^^}/n] " ans
  ans="${ans:-$default}"
  [[ "$ans" =~ ^[Yy] ]]
}

# ── Stow targets per directory ────────────────────────────────────────────
declare -A STOW_TARGETS=(
  [hypr]="$HOME/.config"
  [quickshell]="$HOME/.config"
  [ghostty]="$HOME/.config"
  [fastfetch]="$HOME/.config"
  [matugen]="$HOME/.config"
  [scripts]="$HOME/.config"
  [system]="$HOME/.config"
  [profiles]="$HOME/.config"
  [nvim]="$HOME/.config"
  [zsh]="$HOME"
  [sddm]=""  # handled separately
)

stow_dir() {
  local dir="$1"
  local target="${STOW_TARGETS[$dir]:-}"
  [[ -z "$target" ]] && { echo "  Skipping stow for $dir (no target defined)"; return; }
  [[ ! -d "$ROOT/$dir" ]] && return
  mkdir -p "$target"
  find "$ROOT/$dir" -type f | while IFS= read -r src; do
    local rel="${src#$ROOT/$dir/}"
    if [[ -f "$target/$rel" && ! -L "$target/$rel" ]]; then
      echo "  Removing conflicting: $target/$rel"
      rm -f "$target/$rel"
    fi
  done
  stow -R --target="$target" -d "$ROOT" "$dir" 2>/dev/null || true
}

# ── Install core ──────────────────────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════╗"
echo "║  QSDotfiles Installer               ║"
echo "╚══════════════════════════════════════╝"
echo ""
echo "Installing CORE packages (always)..."
install_pkgs "${GROUPS[CORE]:-}"

# ── Optional groups ───────────────────────────────────────────────────────
if prompt_yn "Install keybinds?"; then
  echo "  (keybinds config included)"
  INSTALL_KEYBINDS=true
else
  INSTALL_KEYBINDS=false
fi

if prompt_yn "Install tuned (power profiles)?"; then
  install_pkgs "tuned"
  sudo systemctl enable --now tuned 2>/dev/null || true
fi

echo ""
echo "SDDM variants:"
echo "  0) None (skip)"
echo "  1) caelestia-sddm-locklike-git"
echo "  2) simple-sddm-theme-2-git (JaKooLit)"
read -rp "Choose [0-2] (default 0): " sddm_choice
sddm_choice="${sddm_choice:-0}"
case "$sddm_choice" in
  1) install_pkgs "caelestia-sddm-locklike-git" ;;
  2) install_pkgs "simple-sddm-theme-2-git" ;;
esac

echo ""
echo "Theme/Profile variants:"
echo "  0) None"
echo "  1) caelestia"
echo "  2) jakoolit"
echo "  3) both"
read -rp "Choose [0-3] (default 0): " profile_choice
profile_choice="${profile_choice:-0}"

if prompt_yn "Install Qt theming (Kvantum + qt6ct)?"; then
  install_pkgs "kvantum qt6ct"
fi

if prompt_yn "Install GTK theming helpers (nwg-look + nwg-displays)?"; then
  install_pkgs "nwg-look nwg-displays"
fi

if prompt_yn "Install extra apps (lazygit, vscode)?"; then
  install_pkgs "lazygit visual-studio-code-bin"
fi

# ── Stow symlinks ─────────────────────────────────────────────────────────
echo ""
echo "Setting up Stow symlinks..."
for dir in "${!STOW_TARGETS[@]}"; do
  if [[ "$dir" == "sddm" && "$sddm_choice" -eq 0 ]]; then
    continue
  fi
  stow_dir "$dir"
done

# Handle sddm separately (needs root)
if [[ "$sddm_choice" -ne 0 ]]; then
  echo ""
  echo "SDDM theme: sudo stow to /etc/sddm.conf.d/"
  sudo stow -R --target="/etc/sddm.conf.d" -d "$ROOT" "sddm" 2>/dev/null || echo "  (skipped — run manually: sudo stow -t /etc/sddm.conf.d -d $ROOT sddm)"
fi

# ── Post-install ──────────────────────────────────────────────────────────
if [[ "$INSTALL_KEYBINDS" == "true" ]]; then
  echo "  Keybinds active: check ~/.config/hypr/UserConfigs/UserKeybinds.conf"
fi

echo ""
echo "╔══════════════════════════════════════╗"
echo "║  Installation complete!              ║"
echo "╚══════════════════════════════════════╝"
echo "Reboot or restart Hyprland to apply."
echo ""
echo "Post-install tips:"
echo "  - Set wallpaper:  ${HOME}/.config/scripts/set-wallpaper.sh ~/P/Wallpapers/your-image.png"
echo "  - Regenerate theme: matugen image ~/Pictures/Wallpapers/your-image.png"
echo "  - Edit keybinds:   ~/.config/hypr/UserConfigs/UserKeybinds.conf"
echo "  - Run vm-mode:     ~/.config/hypr/scripts/vm-mode.sh"
