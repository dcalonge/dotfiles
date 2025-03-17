#!/bin/sh
OPTIONS="daily\nrandom\nexit"
# Mostrar el menú usando rofi
SELECTION=$(printf "$OPTIONS" | bemenu)

random() {
  WALLPAPER_DIR="/home/daniel/Pictures/wallpapers"
  IMAGE=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)

  cp "$IMAGE" /tmp/wallpaper.jpg

  killall swaybg

  exec swaybg -i /tmp/wallpaper.jpg
}

daily() {
  # Fetch JSON data and extract the latest bing_url
  BING_URL=$(curl -s https://bing.npanuhin.me/US/en.json | jq -r 'max_by(.date) | .bing_url')

  # Check if BING_URL is empty or null
  if [ -z "$BING_URL" ] || [ "$BING_URL" = "null" ]; then
    exit 1
  fi

  # Download the image
  if curl -s "$BING_URL" -o /tmp/wallpaper.jpg; then
    killall swaybg
    exec swaybg -i /tmp/wallpaper.jpg
  else
    exit 1
  fi
}

# Tomar acción según la selección del usuario
case "$SELECTION" in
"daily") daily ;;
"random") random ;;
esac
