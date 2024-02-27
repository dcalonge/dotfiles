if status is-interactive
    #neofetch
	# Commands to run in interactive sessions can go here
end

abbr -a dnfu 'sudo dnf upgrade'
abbr -a dnfi 'sudo dnf install'
abbr -a dnfr 'sudo dnf remove'
abbr -a dnfs 'dnf search'
abbr -a hypr 'nvim ~/.config/hypr/hyprland.conf'
alias ls='eza -a --color=always --group-directories-first'
alias v='nvim'
alias cat='bat'

zoxide init fish | source


#cosas de scala
# >>> JVM installed by coursier >>>
set -gx JAVA_HOME "/home/daniel/.cache/coursier/arc/https/github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.22%252B7/OpenJDK11U-jdk_x64_linux_hotspot_11.0.22_7.tar.gz/jdk-11.0.22+7"
set -gx PATH "$PATH:/home/daniel/.cache/coursier/arc/https/github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.22%252B7/OpenJDK11U-jdk_x64_linux_hotspot_11.0.22_7.tar.gz/jdk-11.0.22+7/bin"
# <<< JVM installed by coursier <<<

# >>> coursier install directory >>>
set -gx PATH "$PATH:/home/daniel/.local/share/coursier/bin"
# <<< coursier install directory <<<

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
