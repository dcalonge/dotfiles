if test (tty) = /dev/tty1
    exec river -no-xwayland
    #exec Hyprland
end

if status is-interactive
    #fastfetch
    fortune -s | cowsay -f tux
    # Commands to run in interactive sessions can go here
end



abbr -a pu 'sudo pacman -Syu'
abbr -a pi 'sudo pacman -S'
abbr -a pr 'sudo pacman -Rns'
abbr -a ps 'pacman -Ss'
abbr -a au paru
abbr -a ai 'paru -S'
abbr -a ar 'paru -Rns'
abbr -a as 'paru -Ss'
abbr -a v nvim

alias ls='eza -a --color=always --icons --group-directories-first'
alias cat='bat'
alias sudo='doas'
alias sudoedit='doas rnano'

set -Ux ELECTRON_OZONE_PLATFORM_HINT auto
