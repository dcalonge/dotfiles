#!/bin/sh

case "$(printf "suspend\nlogout\nreboot\npoweroff" | rofi -dmenu)" in
suspend) systemctl suspend ;;
logout) qtile cmd-obj -o cmd -f shutdown ;;
reboot) systemctl reboot ;;
poweroff) systemctl poweroff ;;
esac
