fortune -s | cowsay -f tux


abbr -a pu 'sudo pacman -Syu'
abbr -a pi 'sudo pacman -S'
abbr -a pr 'sudo pacman -Rns'
abbr -a ps 'pacman -Ss'
abbr -a au paru
abbr -a ai 'paru -S'
abbr -a ar 'paru -Rns'
abbr -a as 'paru -Ss'
abbr -a m 'sudo make clean install; rm -f config.h'
abbr -a v nvim

alias ls='eza -a --color=always --icons --group-directories-first'
alias cat='bat'
alias sudo='doas'

set -Ux ELECTRON_OZONE_PLATFORM_HINT auto
