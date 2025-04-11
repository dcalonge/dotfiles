#!/bin/sh

# Fetch JSON data and extract the latest bing_url
BING_URL=$(curl -s https://bing.npanuhin.me/US/en.json | jq -r 'max_by(.date) | .bing_url')

# Check if BING_URL is empty or null
if [ -z "$BING_URL" ] || [ "$BING_URL" = "null" ]; then
  exit 1
fi

# Download the image
if curl -s "$BING_URL" -o ~/Pictures/wallpaper.jpg; then
  killall swaybg
  exec swaybg -i ~/Pictures/wallpaper.jpg
else
  exit 1
fi
