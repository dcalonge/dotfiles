fortune -s | cowsay -f tux


abbr -a fu 'flatpak update'
abbr -a fi 'flatpak install'
abbr -a fr 'flatpak uninstall'
abbr -a fs 'flatpak search'
abbr -a pu 'doas dnf upgrade'
abbr -a pi 'doas dnf install'
abbr -a pr 'doas dnf remove'
abbr -a ps 'dnf search'
abbr -a m 'sudo make clean install; rm -f config.h'
abbr -a v nvim
abbr -a sudo doas


alias ls='eza -a --color=always --icons --group-directories-first'
alias cat='bat'
alias sudo='doas'

set -Ux ELECTRON_OZONE_PLATFORM_HINT auto
