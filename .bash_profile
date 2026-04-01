#
# ~/.bash_profile
#

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
export BEMENU_OPTS='
-l 20 -p ">" -i -w
--fn "JetBrains Mono Nerd Font 16:size=11:antialias=true:hinting=true"

--nb "#222222" --nf "#bbbbbb"
--sb "#005577" --sf "#eeeeee"

--tb "#222222" --tf "#eeeeee"
--fb "#222222" --ff "#bbbbbb"

--hb "#005577" --hf "#eeeeee"

--bdr "#222222" -B 0
'

[[ -f ~/.bashrc ]] && . ~/.bashrc
