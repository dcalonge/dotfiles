# Fun startup
fortune -s | cowsay -f tux

# Flatpak (unchanged)
abbr -a fu 'flatpak update'
abbr -a fi 'flatpak install'
abbr -a fr 'flatpak uninstall'
abbr -a fs 'flatpak search'

# XBPS (Void Linux equivalents)
abbr -a pu 'doas xbps-install -Su' # system update
abbr -a pi 'doas xbps-install' # install package
abbr -a pr 'doas xbps-remove -Rco' # remove package + deps
abbr -a ps 'xbps-query -Rs' # search packages

# AUR helpers → not applicable on Void (remove or repurpose)
# paru equivalents don't really exist; you might use xbps-src manually

# Keep your custom ones
abbr -a m 'sudo make clean install; rm -f config.h'
abbr -a v nvim
abbr -a sudo doas

# Aliases (unchanged)
alias ls='eza -a --color=always --icons --group-directories-first'
alias cat='bat'
alias sudo='doas'

alias svenable='sudo ln -sfv /etc/sv/$1 /var/service/'
alias svdisable='sudo rm /var/service/$1'
alias svstatus='sudo sv status /var/service/*'

# Environment variable
set -Ux ELECTRON_OZONE_PLATFORM_HINT auto
