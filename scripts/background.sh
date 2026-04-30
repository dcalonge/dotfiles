#!/bin/sh
OPTIONS="daily\nrandom\nexit"
# Mostrar el menú usando rofi
SELECTION=$(printf "$OPTIONS" | bemenu)

random() {
  WALLPAPER_DIR="/home/daniel/Pictures/walls"
  IMAGE=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)

  cp "$IMAGE" ~/Pictures/wallpaper.jpg

  killall swaybg

  exec swaybg -i ~/Pictures/wallpaper.jpg
}

daily() {
  BING_URL=$(curl -s https://bing.npanuhin.me/US/en.json | jq -r 'max_by(.date) | .bing_url')

  if [ -z "$BING_URL" ] || [ "$BING_URL" = "null" ]; then
    return 1
  fi

  if curl -s "$BING_URL" -o ~/Pictures/wallpaper.jpg; then
    killall swaybg 2>/dev/null
    exec swaybg -i ~/Pictures/wallpaper.jpg
  else
    return 1
  fi
}

# Tomar acción según la selección del usuario
case "$SELECTION" in
"daily") daily ;;
"random") random ;;
esac
