#!/usr/bin/env bash
# tuned.sh — manage tuned power profiles
# QSDotfiles port (original: ~/.config/waybar/scripts/tuned.sh)
#
# Modes: check | cycle | status | set <profile> | list

PROFILES=(
  "powersave"
  "balanced"
  "latency-performance"
  "throughput-performance"
  "latency-performance"
  "balanced"
)

declare -A ICONS=(
  ["powersave"]=""
  ["balanced"]=""
  ["latency-performance"]=""
  ["throughput-performance"]=""
  ["unknown"]="?"
)

STATE_FILE="${XDG_STATE_HOME:-$HOME/.cache}/tuned-cycle-index"

get_current_profile() {
  tuned-adm active 2>/dev/null | awk '{print $NF}'
}

get_current_index() {
  if [[ -r "$STATE_FILE" ]]; then
    cat "$STATE_FILE"
  else
    echo "-1"
  fi
}

case "$1" in
check)
  current_idx=$(get_current_index)
  if [[ $current_idx -eq -1 ]]; then
    active_profile=$(get_current_profile)
    echo "${ICONS[$active_profile]:-${ICONS[unknown]}}"
  else
    echo "${ICONS[${PROFILES[current_idx]}]:-${ICONS[unknown]}}"
  fi
  ;;
cycle)
  last_idx=$(get_current_index)
  next_idx=$(((last_idx + 1) % ${#PROFILES[@]}))
  new_profile="${PROFILES[next_idx]}"
  if tuned-adm profile "$new_profile" 2>/dev/null; then
    active=$(get_current_profile)
    if [[ "$active" == "$new_profile" ]]; then
      printf "%d" "$next_idx" >|"$STATE_FILE"
      echo "Switched to: $new_profile"
    else
      echo "Warning: Applied $new_profile but tuned reports: $active" >&2
      printf "%d" "$next_idx" >|"$STATE_FILE"
    fi
  else
    echo "Error: Failed to apply profile $new_profile" >&2
    exit 1
  fi
  ;;
set)
  if [[ -z "$2" ]]; then
    echo "Usage: $0 set <profile>" >&2
    exit 1
  fi
  new_profile="$2"
  if tuned-adm profile "$new_profile" 2>/dev/null; then
    active=$(get_current_profile)
    if [[ "$active" == "$new_profile" ]]; then
      # Find index in PROFILES array to update state
      idx=-1
      for i in "${!PROFILES[@]}"; do
        if [[ "${PROFILES[$i]}" == "$new_profile" ]]; then
          idx=$i
          break
        fi
      done
      printf "%d" "$idx" >|"$STATE_FILE"
      echo "Set to: $new_profile"
    else
      echo "Warning: Set $new_profile but tuned reports: $active" >&2
    fi
  else
    echo "Error: Failed to set profile $new_profile" >&2
    exit 1
  fi
  ;;
status)
  current_idx=$(get_current_index)
  active_profile=$(get_current_profile)
  if [[ $current_idx -eq -1 ]]; then
    echo "Cycle position: Not initialized"
  else
    echo "Cycle position: $current_idx (${PROFILES[current_idx]})"
  fi
  echo "Active profile: $active_profile"
  echo "Next in cycle: ${PROFILES[((current_idx + 1) % ${#PROFILES[@]})]}"
  ;;
list)
  echo "Available tuned profiles:"
  tuned-adm list 2>/dev/null || echo "(tuned not running?)"
  echo
  echo "Cycle order:"
  for i in "${!PROFILES[@]}"; do
    echo "  $i: ${PROFILES[$i]}"
  done
  ;;
*)
  echo "Usage: $0 {check|cycle|status|set <profile>|list}"
  exit 1
  ;;
esac
