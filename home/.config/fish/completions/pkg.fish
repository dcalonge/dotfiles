# Fish completions for pkg (~/.local/bin/pkg)

# No file completion; only subcommands and package names.
complete -c pkg -f

# Packages available in the sync databases. Reuses fish's own pacman helper
# (cached, with descriptions) when present, otherwise falls back to pacman.
function __pkg_repo_packages
    if functions -q __fish_print_pacman_packages
        __fish_print_pacman_packages
    else
        pacman -Slq 2>/dev/null
    end
end

# Installed packages, for removal.
function __pkg_installed_packages
    pacman -Qq 2>/dev/null
end

# Subcommands
complete -c pkg -n __fish_use_subcommand -a add -d 'Install packages and add them to pkglist.txt'
complete -c pkg -n __fish_use_subcommand -a rm -d 'Remove packages and drop them from pkglist.txt'
complete -c pkg -n __fish_use_subcommand -a remove -d 'Remove packages and drop them from pkglist.txt'
complete -c pkg -n __fish_use_subcommand -a diff -d 'Compare pkglist.txt with explicitly installed packages'
complete -c pkg -n __fish_use_subcommand -a help -d 'Show usage'
complete -c pkg -n __fish_use_subcommand -s h -l help -d 'Show usage'

# Arguments
complete -c pkg -n '__fish_seen_subcommand_from add' -a '(__pkg_repo_packages)'
complete -c pkg -n '__fish_seen_subcommand_from rm remove' -a '(__pkg_installed_packages)'
