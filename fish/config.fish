if test (tty) = /dev/tty1
    set -Ux BEMENU_OPTS '-W 0.3 -c -l 15 -p ">" --scrollbar autohide -B 2 --bdr "#93a1a1" --ch 20 --cw 2 --fn "JetBrains Mono Nerd Font 12" --tf "#ffffff" --tb "#000000" --ff "#ffffff" --fb "#000000" --cf "#ffffff" --cb "#000000" --nf "#93a1a1" --nb "#000000" --hf "#ffffff" --hb "#000000" --fbf "#ffffff" --fbb "#000000" --sf "#ffffff" --sb "#000000" --af "#93a1a1" --ab "#000000" --scf "#93a1a1" --scb "#000000" -i -w -H 40'
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
