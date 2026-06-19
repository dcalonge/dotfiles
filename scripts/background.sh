#!/bin/sh
OPTIONS="daily\nrandom\ngallery\nexit"
SELECTION=$(printf "$OPTIONS" | fuzzel --dmenu)
WALLPAPER_DIR="/home/daniel/Pictures/walls"
WALLPAPER_LINK="$HOME/Pictures/wallpaper"

set_wallpaper() {
  IMAGE="$1"
  [ -z "$IMAGE" ] && return

  ln -sf "$IMAGE" "$WALLPAPER_LINK"
  pkill swaybg 2>/dev/null
  swaybg -i "$WALLPAPER_LINK"
  matugen image "$WALLPAPER_LINK" \
    -m dark \
    -t scheme-tonal-spot \
    --source-color-index 0
}

random() {
  IMAGE=$(find "$WALLPAPER_DIR" -type f \
    \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) |
    shuf -n 1)

  set_wallpaper "$IMAGE"
}

gallery() {
  tmp_file=$(mktemp)
  trap 'rm -f "$tmp_file"' EXIT
  foot -a yazi-floating -e sh -c "
    cd '$WALLPAPER_DIR' &&
    yazi . --chooser-file='$tmp_file'
  "
  image=$(cat "$tmp_file")
  if [ -n "$image" ] && [ -f "$image" ]; then
    if file --mime-type -b "$image" | grep -q '^image/'; then
      set_wallpaper "$image"
    else
      echo "Selection rejected: '$image' is not an image file."
    fi
  fi
}

daily() {
  BING_URL=$(curl -s https://bing.npanuhin.me/US/en.json |
    jq -r 'max_by(.date) | .bing_url')
  if [ -z "$BING_URL" ] || [ "$BING_URL" = "null" ]; then
    return 1
  fi
  BING_FILE="$WALLPAPER_DIR/bing_daily.jpg"
  if curl -s "$BING_URL" -o "$BING_FILE"; then
    set_wallpaper "$BING_FILE"
  fi
}

case "$SELECTION" in
"daily") daily ;;
"random") random ;;
"gallery") gallery ;;
"exit") exit 0 ;;
esac
