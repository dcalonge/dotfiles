# Installation

Clone the repository and run the installer:

bash
```
git clone https://github.com/dcalonge/dotfiles.git
cd dotfiles
chmod +x install
./install
```

The installer is designed for Arch Linux and automates the setup of your environment.

## What the installer does

- Dependencies: Installs prerequisites, including Git, `base-devel`, and GNU Stow.
- AUR helper: Installs [`paru`](<https://github.com/Morganamilo/paru?utm_source=chatgpt.com>) if it is not already installed.
- Packages: Installs packages listed in `pkglist.txt`, supporting both official repositories and the AUR.
- Dotfiles: Uses GNU Stow to create symlinks for your configuration files.
- Pacman hooks: Installs hooks from `pacman/hooks/` into `/etc/pacman.d/hooks/` and removes stale symlinks managed by the repository.

## Repository structure

text
```
dotfiles/
├── install
├── .bashrc
├── .bash_profile
├── .config/
├── .local/
│   └── bin/
├── pacman/
│   └── hooks/
└── pkglist.txt
```

## Managing dotfiles

Configuration files are managed with GNU Stow. The repository is the source of truth, while symlinks expose files at their expected locations in your home directory.

For example:

- Repository: `~/dotfiles/.config/mango/config.conf`
- Actual configuration: `~/.config/mango/config.conf`

Both paths refer to the same file, so changes made through either path are immediately reflected in the other. You do not need to rerun Stow when editing an existing configuration.

When adding new files or changing the repository structure, rerun the installer to create or reconcile the symlinks.

## Managing packages

Add or remove package names in `pkglist.txt`. Run the installer again to install newly listed packages.

Removing a package from the list does not automatically uninstall it. Remove packages explicitly with `paru` or `pacman` when appropriate.

## Managing pacman hooks

Place custom `.hook` files in `pacman/hooks/`. The installer creates symlinks in `/etc/pacman.d/hooks/`, keeping hook definitions version-controlled alongside the rest of your dotfiles.

Pacman hooks may execute commands with root privileges. Ensure that hook definitions and any scripts they invoke are trusted and appropriately protected.

## Notes

- The installer may request your password for privileged operations.
- GNU Stow reports conflicts rather than automatically overwriting existing files. Resolve conflicts before rerunning the installer.
- Review package installation prompts and hook behavior before confirming changes.
- Back up important configuration files before making major changes.
