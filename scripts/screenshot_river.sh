#!/bin/sh

GEOMETRY=$(slurp)
if [ $? -ne 0 ]; then
  GEOMETRY="0,0 1920x1080" # Default to fullscreen if slurp fails
fi

CHOICE=$(printf "Save\nCopy\nSave & Copy\nAbort" | bemenu)

case "$CHOICE" in
Save)
  grim -g "$GEOMETRY"
  ;;
Copy)
  grim -g "$GEOMETRY" - | wl-copy
  ;;
Save+copy)
  grim -g "$GEOMETRY" && grim -g "$GEOMETRY" - | wl-copy
  ;;
Abort)
  exit 0
  ;;
esac
