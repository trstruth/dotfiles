#!/usr/bin/env bash
set -euo pipefail

wallpaper_dir="$HOME/Pictures/wallpapers"
config_path="$HOME/.config/hypr/hyprpaper.conf"

wallpaper_path="$(
  find "$wallpaper_dir" -maxdepth 1 -type f \( \
    -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' -o -iname '*.bmp' \
  \) -print | shuf -n 1
)"

mapfile -t monitors < <(
  hyprctl monitors -j | jq -r '.[] | .name // empty'
)

if [[ -z "${wallpaper_path}" ]]; then
  printf 'No wallpapers found in %s\n' "$wallpaper_dir" >&2
  exit 1
fi

if (( ${#monitors[@]} == 0 )); then
  printf 'No monitors detected via hyprctl\n' >&2
  exit 1
fi

{
  printf 'ipc = off\n'
  printf 'preload = %s\n' "$wallpaper_path"

  for monitor in "${monitors[@]}"; do
    printf 'wallpaper {\n'
    printf '  monitor = %s\n' "$monitor"
    printf '  path = %s\n' "$wallpaper_path"
    printf '  fit_mode = cover\n'
    printf '}\n'
  done
} > "$config_path"

exec hyprpaper
