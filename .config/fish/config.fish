fortune -s | cowsay -f tux

abbr -a fu 'flatpak update'
abbr -a fi 'flatpak install'
abbr -a fr 'flatpak uninstall'
abbr -a fs 'flatpak search'
abbr -a pu 'doas pacman -Syu'
abbr -a pi 'doas pacman -S'
abbr -a pr 'doas pacman -Rns'
abbr -a ps 'pacman -Ss'
abbr -a au paru
abbr -a ai paru

abbr -a m 'sudo make clean install; rm -f config.h'
abbr -a v nvim
abbr -a sudo doas

alias ls='eza -a --color=always --icons --group-directories-first'
alias cat='bat'
alias sudo='doas'

set -Ux ELECTRON_OZONE_PLATFORM_HINT auto
