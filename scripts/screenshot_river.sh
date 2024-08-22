#!/bin/sh

GEOMETRY=$(slurp) &&
  CHOICE=$(printf "Save\nCopy\nSave+copy\nAbort" | bemenu)

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
