#!/usr/bin/env bash
set -euo pipefail

wallpaper_dir="$HOME/Pictures/wallpapers"
config_path="$HOME/.config/hypr/hyprpaper.conf"

wallpaper_path="$(
  find "$wallpaper_dir" -maxdepth 1 -type f \( \
    -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' -o -iname '*.bmp' \
  \) -print | shuf -n 1
)"

if [[ -z "${wallpaper_path}" ]]; then
  printf 'No wallpapers found in %s\n' "$wallpaper_dir" >&2
  exit 1
fi

cat > "$config_path" <<EOF
ipc = off
preload = ${wallpaper_path}
wallpaper = ,${wallpaper_path}
EOF

exec hyprpaper
