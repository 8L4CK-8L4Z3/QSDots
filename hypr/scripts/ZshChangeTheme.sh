#!/usr/bin/env bash
# Change oh-my-zsh theme
THEME="${1:-random}"
ZSH_RC="$HOME/.zshrc"

if [[ "$THEME" == "random" ]]; then
  THEMES=($(ls $ZSH/themes/*.zsh-theme 2>/dev/null | xargs basename -a | sed 's/\.zsh-theme$//'))
  COUNT=${#THEMES[@]}
  if [[ $COUNT -eq 0 ]]; then
    notify-send "Zsh Theme" "No themes found"
    exit 1
  fi
  THEME="${THEMES[RANDOM % COUNT]}"
fi

if grep -q '^ZSH_THEME=' "$ZSH_RC"; then
  sed -i "s/^ZSH_THEME=.*/ZSH_THEME=\"$THEME\"/" "$ZSH_RC"
else
  echo "ZSH_THEME=\"$THEME\"" >> "$ZSH_RC"
fi
notify-send "Zsh Theme" "Changed to: $THEME"
