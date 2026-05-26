#
# ~/.bash_profile
#
export LIBVA_DRIVER_NAME=radeonsi
export VDPAU_DRIVER=va_gl
export XCURSOR_SIZE=24
export XCURSOR_THEME=Adwaita
export $(dbus-launch)
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export GRIM_DEFAULT_DIR="/home/daniel/Pictures/"
export PATH="$HOME/.local/bin:$PATH"
export ELECTRON_OZONE_PLATFORM_HINT='auto'
export XDG_CURRENT_DESKTOP=niri
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=niri
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_QPA_PLATFORMTHEME=gtk3
export EDITOR="nvim"
flatpak override --user \
  --env=CHROME_EXTRA_FLAGS="\
     --enable-features=AcceleratedVideoEncoder,VaapiVideoDecoder,AcceleratedVideoDecodeLinuxGL,TouchpadOverscrollHistoryNavigation,FluentOverlayScrollbar \
     --ozone-platform-hint=wayland \
     --password-store=basic \
     --disk-cache-size=1 --v8-cache-options=none" \
  io.github.ungoogled_software.ungoogled_chromium

[[ -f ~/.bashrc ]] && . ~/.bashrc
