#
# ~/.bashrc
#

start_dwl() {
  while true; do
    dwmblocks | dwl -s /home/daniel/scripts/autostart.sh >~/.dwl.log 2>&1
  done
}

if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec river -no-xwayland >~/.river.log 2>&1
  # start_dwl
  exit
fi
