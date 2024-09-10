#!/bin/sh

# Path to wallpapers
WALLPAPER_DIR="/home/daniel/Pictures/macos"
# Number of wallpapers
NUM_WALLPAPERS=16

# Function to set the wallpaper
set_wallpaper() {
  local wallpaper_number=$1
  pkill swaybg
  swaybg -i "${WALLPAPER_DIR}/mojave_dynamic_${wallpaper_number}.jpeg" -m fill
}

while true; do
  current_hour=$(date +"%H")
  current_minute=$(date +"%M")
  total_minutes=$(($current_hour * 60 + $current_minute))

  minutes_since_six=$(((total_minutes - 360 + 1440) % 1440))
  wallpaper_index=$((minutes_since_six / 90))
  wallpaper_number=$(((wallpaper_index % NUM_WALLPAPERS) + 1))

  set_wallpaper "$wallpaper_number"

  sleep 10m
done
