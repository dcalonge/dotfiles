fortune -s | cowsay -f tux

abbr -a fu 'flatpak update'
abbr -a fi 'flatpak install'
abbr -a fr 'flatpak uninstall'
abbr -a fs 'flatpak search'
abbr -a pu 'sudo pacman -Syu'
abbr -a pi 'sudo pacman -S'
abbr -a pr 'sudo pacman -Rns'
abbr -a ps 'pacman -Ss'
abbr -a au paru
abbr -a ai paru

abbr -a v nvim

alias ls='eza -a --color=always --icons --group-directories-first'
alias cat='bat'

set -Ux ELECTRON_OZONE_PLATFORM_HINT auto
