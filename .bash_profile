#
# ~/.bash_profile
#

export BEMENU_OPTS='-W 0.3 -c -l 20 -p ">" --scrollbar autohide -B 2 --bdr "#93a1a1" --ch 20 --cw 2 --fn "JetBrains Mono Nerd Font 12" --tf "#eeeeee" --tb "#000000" --ff "#eeeeee" --fb "#000000" --cf "#eeeeee" --cb "#000000" --nf "#93a1a1" --nb "#000000" --hf "#eeeeee" --hb "#000000" --fbf "#eeeeee" --fbb "#000000" --sf "#eeeeee" --sb "#000000" --af "#93a1a1" --ab "#000000" --scf "#93a1a1" --scb "#000000" -i -w -H 40'
export GRIM_DEFAULT_DIR="/home/daniel/Pictures/"
export PATH="$HOME/.local/bin:$PATH"
export ELECTRON_OZONE_PLATFORM_HINT='auto'
export XDG_CURRENT_DESKTOP=wlroots
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=wlroots
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR="nvim"

[[ -f ~/.bashrc ]] && . ~/.bashrc
