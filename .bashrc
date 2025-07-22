#
# ~/.bashrc
#

if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec river -no-xwayland >~/.river.log 2>&1
fi
