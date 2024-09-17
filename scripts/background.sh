#!/bin/sh

WALLPAPER_DIR="/home/daniel/Pictures/wallpapers"
RANDOM_IMAGE=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)

cp "$RANDOM_IMAGE" /tmp/wallpaper.jpg

killall swaybg

exec swaybg -i /tmp/wallpaper.jpg
