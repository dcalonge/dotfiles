#!/bin/sh

FOCUSED=$(swaymsg -t get_tree | jq '.. | (.nodes? // empty)[] | select(.focused and .pid) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')

CHOICE2=$(printf "Fullscreen\nSelection\nFocus\nAbort" | rofi -dmenu -p "Elige una opción:")

case "$CHOICE2" in
Fullscreen)
  GEOMETRY="fullscreen"
  ;;
Selection)
  GEOMETRY=$(slurp)
  ;;
Focus)
  GEOMETRY=$(eval echo $FOCUSED)
  ;;
Abort)
  exit 0
  ;;
*)
  exit 0
  ;;
esac

CHOICE1=$(printf "Save\nCopy\nSave+copy\nAbort" | rofi -dmenu)

case "$CHOICE1" in
Save)
  case "$CHOICE2" in
  Fullscreen) grim ;;
  Selection) grim -g "$GEOMETRY" ;;
  Focus) grim -g "$GEOMETRY" ;;
  Abort) exit 0 ;;
  esac
  ;;
Copy)
  case "$CHOICE2" in
  Fullscreen) grim - | wl-copy ;;
  Selection) grim -g "$GEOMETRY" - | wl-copy ;;
  Focus) grim -g "$GEOMETRY" - | wl-copy ;;
  Abort) exit 0 ;;
  esac
  ;;
Save+copy)
  case "$CHOICE2" in
  Fullscreen)
    grim && grim - | wl-copy
    ;;
  Selection)
    grim -g "$GEOMETRY" && grim -g "$GEOMETRY" - | wl-copy
    ;;
  Focus)
    grim -g "$GEOMETRY" && grim -g "$GEOMETRY" - | wl-copy
    ;;
  Abort) exit 0 ;;
  esac
  ;;
Abort)
  exit 0
  ;;
esac
