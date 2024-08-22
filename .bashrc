# Check if the current terminal is /dev/tty1
if [ "$(tty)" = "/dev/tty1" ]; then
  # Set BEMENU_OPTS environment variable with desired options
  export BEMENU_OPTS='-W 0.3 -c -l 15 -p ">" --scrollbar autohide -B 2 --bdr "#93a1a1" --ch 20 --cw 2 --fn "JetBrains Mono Nerd Font 12" --tf "#ffffff" --tb "#000000" --ff "#ffffff" --fb "#000000" --cf "#ffffff" --cb "#000000" --nf "#93a1a1" --nb "#000000" --hf "#ffffff" --hb "#000000" --fbf "#ffffff" --fbb "#000000" --sf "#ffffff" --sb "#000000" --af "#93a1a1" --ab "#000000" --scf "#93a1a1" --scb "#000000" -i -w -H 40'
  exec river -no-xwayland
  #exec Hyprland
fi

# Commands to run in interactive sessions
if [[ $- == *i* ]]; then
  fortune -s | cowsay -f tux
  fish
  # Commands to run in interactive sessions can go here
fi

# Aliases for pacman and paru
alias pu='sudo pacman -Syu'
alias pi='sudo pacman -S'
alias pr='sudo pacman -Rns'
alias ps='pacman -Ss'
alias au='paru'
alias ai='paru -S'
alias ar='paru -Rns'
alias as='paru -Ss'
alias v='nvim'

# Other aliases
alias ls='eza -a --color=always --icons --group-directories-first'
alias cat='bat'
alias sudo='doas'
alias sudoedit='doas rnano'

# Set ELECTRON_OZONE_PLATFORM_HINT environment variable
export ELECTRON_OZONE_PLATFORM_HINT='auto'
