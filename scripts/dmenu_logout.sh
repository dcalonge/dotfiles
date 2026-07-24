#!/bin/sh

case "$(printf "logout\nsuspend\nreboot\npoweroff" | fuzzel -d)" in
suspend) systemctl suspend ;;
logout) loginctl terminate-user "" ;;
reboot) systemctl reboot ;;
poweroff) systemctl poweroff ;;
esac
