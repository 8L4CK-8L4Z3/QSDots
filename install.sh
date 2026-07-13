#!/usr/bin/env bash
# QSDotfiles — opt-in installer
# CORE always installed. Optional groups prompted interactively.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

# ── Detect AUR helper ──────────────────────────────────────────────────
AUR=""
for cmd in yay paru pacman; do
  if command -v "$cmd" &>/dev/null; then
    AUR="$cmd"
    break
  fi
done
if [[ -z "$AUR" ]]; then
  echo "No package manager found (yay/paru/pacman). Aborting." >&2
  exit 1
fi
echo "Using package manager: $AUR"

# ── Parse packages.txt ─────────────────────────────────────────────────
declare -A GROUPS
GROUP=""
while IFS= read -r line; do
  line="${line%%#*}" # strip comments
  line="${line## *}"
  line="${line%% *}"
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
  if [[ "$AUR" == "pacman" ]]; then
    sudo pacman -S --needed --noconfirm $pkgs 2>/dev/null || true
  else
    "$AUR" -S --needed --noconfirm $pkgs 2>/dev/null || true
  fi
}

prompt_yn() {
  local prompt="$1"
  local default="${2:-y}"
  local ans
  read -rp "$prompt [${default^^}/n] " ans
  ans="${ans:-$default}"
  [[ "$ans" =~ ^[Yy] ]]
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
OPTIONAL_KEYS=()
while IFS='=' read -r key val; do
  [[ -z "$key" ]] && continue
  OPTIONAL_KEYS+=("$key")
done < <(grep '^[a-z]' packages.txt | grep '=' | head -20)

# keybinds
if prompt_yn "Install keybinds?"; then
  echo "  (keybinds config included — no extra packages)"
fi

# power
if prompt_yn "Install tuned (power profiles)?"; then
  install_pkgs "tuned"
fi

# sddm
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

# profiles
echo ""
echo "Theme/Profile variants:"
echo "  0) None"
echo "  1) caelestia"
echo "  2) jakoolit"
echo "  3) both"
read -rp "Choose [0-3] (default 0): " profile_choice
profile_choice="${profile_choice:-0}"
case "$profile_choice" in
  1|3) echo "  (caelestia profile selected)" ;;
esac
case "$profile_choice" in
  2|3) echo "  (jakoolit profile selected)" ;;
esac

# qt-theming
if prompt_yn "Install Qt theming (Kvantum + qt6ct)?"; then
  install_pkgs "kvantum qt6ct"
fi

# gtk-theming
if prompt_yn "Install GTK theming helpers (nwg-look + nwg-displays)?"; then
  install_pkgs "nwg-look nwg-displays"
fi

# apps
if prompt_yn "Install extra apps (lazygit, vscode)?"; then
  install_pkgs "lazygit visual-studio-code-bin"
fi

# ── Stow symlinks ─────────────────────────────────────────────────────────
echo ""
echo "Setting up Stow symlinks..."
STOW_DIRS=(hypr quickshell matugen ghostty zsh fastfetch scripts system profiles)
for dir in "${STOW_DIRS[@]}"; do
  if [[ -d "$ROOT/$dir" ]]; then
    stow -R --target="$HOME" -d "$ROOT" "$dir" 2>/dev/null || stow --target="$HOME" -d "$ROOT" "$dir"
  fi
done

echo ""
echo "╔══════════════════════════════════════╗"
echo "║  Installation complete!              ║"
echo "╚══════════════════════════════════════╝"
echo "Reboot or restart Hyprland to apply."
echo ""
echo "Post-install tips:"
echo "  - Set wallpaper:  swww img ~/Pictures/Wallpapers/your-wallpaper.png"
echo "  - Regenerate theme: matugen image ~/Pictures/Wallpapers/your-wallpaper.png"
echo "  - Edit keybinds:   ~/.config/hypr/UserConfigs/UserKeybinds.conf"
