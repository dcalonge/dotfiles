#!/bin/sh

case "$(printf "logout\nsuspend\nreboot\npoweroff\nuefi" | fuzzel --dmenu)" in
suspend) loginctl suspend ;;
logout) loginctl terminate-user "" ;;
reboot) loginctl reboot ;;
poweroff) loginctl poweroff ;;
uefi) loginctl reboot --firmware-setup ;;
esac
