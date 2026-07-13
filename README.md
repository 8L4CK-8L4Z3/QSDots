# QSDotfiles

Personal Hyprland dotfiles built from scratch — **Quickshell-only** (no rofi, no Waybar).
Jakoolit-style modular architecture with optional Caelestia and Jakoolit profiles.
GPL-3.0 licensed.

## Architecture

- **WM:** Hyprland with modular `UserConfigs/`
- **UI engine:** Quickshell (`shell.qml` + QML components)
- **Theming:** matugen + swww → one generated palette → all components
- **Profiles:** `caelestia` or `jakoolit` look (switchable via Settings or `switch-profile.sh`)
- **Deploy:** GNU Stow + opt-in `install.sh`

## Components

| Keybind | Component |
|---------|-----------|
| `Super+D` / `Super+S` | App search / launcher |
| `Super+A` | Overview (workspace grid + stats) |
| `Super+N` | Notification center + Android-style toggle tiles |
| `Super+H` | Help menu (keybinds) |
| `Super+W` | Wallpaper chooser |
| `Super+,` | Settings (profile, blur, opacity, wallpaper) |
| `Super+Alt+E` | Emoji picker |
| `Super+Alt+C` | Calculator |
| `Super+Alt+V` | Clipboard manager |
| `Super+Shift+P` | Cycle tuned power profile |

## Quick start

```bash
# Clone
git clone https://github.com/8l4z3/QSDotfiles ~/dotfiles
cd ~/dotfiles

# Install
./install.sh

# Set wallpaper
~/.config/scripts/set-wallpaper.sh ~/Pictures/Wallpapers/your-image.png

# Apply VM mode (if testing)
~/.config/hypr/scripts/vm-mode.sh
```

## Profiles

```bash
# List available profiles
ls ~/.config/profiles/

# Switch profile
switch-profile.sh caelestia
switch-profile.sh jakoolit
```

## Secrets

Sensitive values (`HF_TOKEN`, SSH, API keys) go in `~/.config/zsh/secrets` — that file is gitignored.
See `zsh/secrets.example` for the format.

## Credits

- **caelestia-dots** (ItsABigIgloo) — GPL-3.0 Quickshell QML patterns
- **JaKooLit** (JaKooLit) — GPL-3.0 modular Hyprland structure, tuned keybinds, simple-sddm-2
- **Hyprland** — BSD-3-Clause
- **Quickshell** (outfoxxed) — LGPL-2.1
- **matugen** (InioX) — MIT
