# Check if the current terminal is /dev/tty1
export XDG_CURRENT_DESKTOP="sway"
# Set ELECTRON_OZONE_PLATFORM_HINT environment variable
export ELECTRON_OZONE_PLATFORM_HINT='auto'

if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  export QT_QPA_PLATFORM=wayland
  export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
  export QT_STYLE_OVERRIDE="qt5ct"
  export QT_QPA_PLATFORMTHEME="qt5ct"
  export BEMENU_OPTS='-W 0.3 -c -l 15 -p ">" --scrollbar autohide -B 2 --bdr "#93a1a1" --ch 20 --cw 2 --fn "JetBrains Mono Nerd Font 12" --tf "#eeeeee" --tb "#000000" --ff "#eeeeee" --fb "#000000" --cf "#eeeeee" --cb "#000000" --nf "#93a1a1" --nb "#000000" --hf "#eeeeee" --hb "#000000" --fbf "#eeeeee" --fbb "#000000" --sf "#eeeeee" --sb "#000000" --af "#93a1a1" --ab "#000000" --scf "#93a1a1" --scb "#000000" -i -w -H 40'
  #exec river -no-xwayland
  someblocks | dwl -s /home/daniel/scripts/autostart.sh >~/.dwl.log 2>&1
  killall dbus-daemon
  exit
fi

# Commands to run in interactive sessions
#if [[ $- == *i* ]]; then
#fortune -s | cowsay -f tux
#exec fish
# Commands to run in interactive sessions can go here
#fi
