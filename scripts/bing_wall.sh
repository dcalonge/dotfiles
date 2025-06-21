#!/bin/sh

bing() {
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

natgeo() {
  nat_geo_page_url="https://www.nationalgeographic.com/photo-of-the-day/"
  html_content=$(curl -s "$nat_geo_page_url")
  meta_og_image=$(printf "%s\n" "$html_content" | grep -o '<meta [^>]*property="og:image"[^>]*>')
  content_value=$(printf "%s\n" "$meta_og_image" | grep -o 'content="[^"]*"')
  image_url=$(printf "%s\n" "$content_value" | sed 's/content="\([^"]*\)"/\1/')

  if [ -z "$image_url" ] || [ "$image_url" = "null" ]; then
    return 1
  fi

  output_file="$HOME/Pictures/wallpaper.jpg"

  if curl -s "$image_url" -o "$output_file"; then
    killall swaybg 2>/dev/null
    exec swaybg -i "$output_file"
  else
    return 1
  fi
}

if [ $# -eq 0 ]; then
  choice=$(printf "bing\nnatgeo" | bemenu)
else
  choice="$1"
fi

case "$choice" in
"bing") bing ;;
"natgeo") natgeo ;;
esac
