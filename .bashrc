#
# ~/.bashrc
#

if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec mango >~/.mango.log 2>&1
  # exec sway >~/.sway.log 2>&1

fi
