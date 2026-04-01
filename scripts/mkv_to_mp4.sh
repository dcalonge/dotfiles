#!/bin/bash

for f in *.mkv; do
  [ -e "$f" ] || continue
  ffmpeg -i "$f" -c:v libx264 -preset ultrafast -crf 28 -c:a aac -b:a 128k "${f%.mkv}.mp4"
done
