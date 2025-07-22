#!/bin/sh

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
