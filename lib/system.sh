# shellcheck shell=bash
#
# Helpers for the system/ tree: the files under system/ that are copied into /.
# Sourced by ./install and by ~/.local/bin/sys so that both agree on what
# "installed" means. Functions only; sourcing this file has no side effects.
#
# Paths are always relative to the filesystem root, e.g. "etc/iwd/main.conf".

# Paths (files or directories, relative to /) that must be installed 0600
# instead of the default 0644. Git cannot record permission bits beyond the
# executable flag, so anything private - keys, credentials, tokens - has to be
# listed here or it would land world-readable in /etc.
SYSTEM_PRIVATE_PATHS=(
    "etc/wireguard"
)

# Permission bits to install a path with.
system_mode() {
    local rel="$1" path

    for path in "${SYSTEM_PRIVATE_PATHS[@]}"; do
        if [[ "$rel" == "$path" || "$rel" == "$path"/* ]]; then
            printf '600\n'
            return 0
        fi
    done

    printf '644\n'
}

# Every file managed under a system/ tree.
system_files() {
    find "$1" \( -type f -o -type l \) -print0
}

# Compare one repository file with what is installed at the root.
# Prints one of:
#   ok          installed, same contents, same mode, owned by root
#   missing     nothing at the destination
#   differs     something else is there: stale contents, wrong mode or owner,
#               or a symlink
#   unreadable  exists, but this user may not read it (e.g. a 0600 root file)
system_state() {
    local src="$1" dest="$2" rel="$3"

    if [[ ! -e "$dest" && ! -L "$dest" ]]; then
        printf 'missing\n'
        return 0
    fi

    # A symlink is never a valid install target: /etc is read at boot, before
    # $HOME is guaranteed to be mounted.
    if [[ -L "$dest" || ! -f "$dest" ]]; then
        printf 'differs\n'
        return 0
    fi

    if [[ ! -r "$dest" ]]; then
        printf 'unreadable\n'
        return 0
    fi

    if cmp -s -- "$src" "$dest" 2>/dev/null &&
        [[ "$(stat -c '%a' -- "$dest")" == "$(system_mode "$rel")" ]] &&
        [[ "$(stat -c '%U:%G' -- "$dest")" == "root:root" ]]; then
        printf 'ok\n'
    else
        printf 'differs\n'
    fi
}
