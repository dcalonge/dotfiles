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

# Tomar acción según la selección del usuario
case "$SELECTION" in
"daily") ~/scripts/bing_wall.sh ;;
"random") random ;;
esac
