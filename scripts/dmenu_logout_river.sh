#!/bin/sh

case "$(printf "logout\nsuspend\nreboot\npoweroff" | rofi -dmenu -p "Elige una opción:")" in
suspend) systemctl suspend ;;
logout) riverctl exit ;;
reboot) systemctl reboot ;;
poweroff) systemctl poweroff ;;
esac
