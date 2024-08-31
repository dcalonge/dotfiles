#!/bin/sh

case "$(printf "suspend\nreboot\npoweroff" | bemenu)" in
suspend) systemctl suspend ;;
reboot) systemctl reboot ;;
poweroff) systemctl poweroff ;;
esac
