# Installation

Clone the repository and run the installer:

```bash
git clone https://github.com/dcalonge/dotfiles.git
cd dotfiles
chmod +x install
./install
```

The installer is designed for Arch Linux and automates the setup of your environment.

If a file in your home directory already exists where the repository has one (for example a default `~/.bashrc`), the repository version wins. The installer moves the existing file to `~/.dotfiles-backup/<timestamp>/`, keeping its relative path, and then creates the symlink. Nothing is deleted; remove the backup directory once you are happy with the result.

## What the installer does

- **Dependencies:** Installs prerequisites, including Git, `base-devel`, and GNU Stow.
- **AUR helper:** Installs [`paru`](https://github.com/Morganamilo/paru) if it is not already installed.
- **Packages:** Installs packages listed in `pkglist.txt`, supporting both official repositories and the AUR.
- **Dotfiles:** Uses GNU Stow to symlink everything in `home/` into your home directory.

## Repository structure

```text
dotfiles/
├── install
├── pkglist.txt
├── README.md
├── assets/
└── home/                 # Stow package: mirrors $HOME
    ├── .bashrc
    ├── .bash_profile
    ├── .config/
    └── .local/
        └── bin/
```

Everything inside `home/` is a mirror of your home directory. Everything outside it is repository tooling and is never linked into `$HOME`.

## Managing dotfiles

Configuration files are managed with [GNU Stow](https://www.gnu.org/software/stow/). The repository is the source of truth, while symlinks expose files at their expected locations in your home directory.

For example:

- Repository: `~/dotfiles/home/.config/mango/config.conf`
- Actual configuration: `~/.config/mango/config.conf`

Both paths refer to the same file, so changes made through either path are immediately reflected in the other. You do not need to rerun Stow when editing an existing configuration.

The installer creates `~/.config` and `~/.local/bin` as real directories before running Stow. This means Stow links the individual app directories inside them (for example `~/.config/niri`) rather than replacing `~/.config` itself with a symlink.

### Adding dotfiles

1. Move the file or directory into `home/`, keeping the same path it has relative to `$HOME`:

   ```bash
   # a single file in $HOME
   mv ~/.zshrc ~/dotfiles/home/.zshrc

   # an app directory in ~/.config
   mkdir -p ~/dotfiles/home/.config
   mv ~/.config/foo ~/dotfiles/home/.config/foo

   # a single file inside ~/.config/foo (leave the rest of the directory alone)
   mkdir -p ~/dotfiles/home/.config/foo
   mv ~/.config/foo/config.toml ~/dotfiles/home/.config/foo/config.toml
   ```

2. Preview what Stow will do (optional, but a good habit):

   ```bash
   stow -n -v --dir="$HOME/dotfiles" --target="$HOME" --restow home
   ```

3. Create the symlinks. Either rerun `./install`, or run Stow directly:

   ```bash
   stow --dir="$HOME/dotfiles" --target="$HOME" --restow home
   ```

4. Check the result and commit:

   ```bash
   ls -l ~/.config/foo
   cd ~/dotfiles && git add -A && git commit -m "Add foo config"
   ```

Before committing, check that you are not adding caches, history files, tokens, or other secrets. Add anything that should stay out of the repository to `.gitignore`.

Notes:

- Scripts in `home/.local/bin` must be executable. The installer runs `chmod +x` on them before stowing, but commit the mode too (`git add --chmod=+x home/.local/bin/<script>`, or `chmod +x` before `git add`) so it is stored in the repository.
- Moving a whole app directory also moves anything the app stored there (cache, state, credentials). If that is a problem, add only the specific files you want, as in the third example above.
- Stow only creates links for files that exist in the repository. If you run `stow` directly and a real file already exists at the destination, Stow reports a conflict and does nothing. Rerunning `./install` instead backs up the existing file and replaces it with the link.

### Removing dotfiles

Remove the symlink **before** deleting the file from the repository. Stow works from the repository contents, so once a file is gone from `home/` it can no longer tell which link belonged to it and leaves a dangling symlink behind.

1. Remove the symlinks for the whole package:

   ```bash
   stow -D --dir="$HOME/dotfiles" --target="$HOME" home
   ```

   Or, to remove just one, delete the link by hand (check it is a symlink first):

   ```bash
   ls -ld ~/.config/foo
   rm ~/.config/foo
   ```

2. Optionally keep a local, unmanaged copy of the config:

   ```bash
   cp -a ~/dotfiles/home/.config/foo ~/.config/foo
   ```

3. Delete it from the repository and commit:

   ```bash
   cd ~/dotfiles
   git rm -r home/.config/foo
   git commit -m "Remove foo config"
   ```

4. If you removed the whole package's links in step 1, restore the rest by rerunning `./install` or:

   ```bash
   stow --dir="$HOME/dotfiles" --target="$HOME" --restow home
   ```

To find leftover dangling links after the fact:

```bash
find ~ -maxdepth 4 -xtype l -lname '*dotfiles/*'
```

Review the output, then add `-delete` to remove them.

## Managing packages

Packages are listed in `pkglist.txt`, one name per line. Lines starting with `#` and blank lines are ignored, so you can use them to group packages.

The `pkg` helper (`home/.local/bin/pkg`, linked to `~/.local/bin/pkg`) installs or removes packages and updates `pkglist.txt` for you:

```bash
pkg add htop ripgrep      # paru -S --needed, then add to pkglist.txt
pkg rm htop               # paru -Rns, then remove from pkglist.txt
pkg diff                  # compare pkglist.txt with what is installed
```

- A package is only added to the list once it is actually installed, and only removed once it is actually gone. If you cancel at the prompt, `pkglist.txt` is left alone.
- Comments and grouping in `pkglist.txt` are preserved.
- `pkg add` also works for packages that are already installed, which is a quick way to start tracking one.
- Packages installed or removed with plain `pacman` or `paru` are not recorded. Run `pkg diff` to see what has drifted: it lists packages that are in the file but not explicitly installed, and explicitly installed packages that are not in the file. The second list includes base system packages such as `base` and `linux`, which you can add or ignore.
- Commit `pkglist.txt` after changing it.
- Fish completions for `pkg` live in `home/.config/fish/completions/pkg.fish`: subcommands, repo package names after `add`, and installed package names after `rm`. AUR package names are not completed.

You can also edit `pkglist.txt` by hand. Run the installer again to install newly listed packages. Removing a name from the file does not uninstall the package; use `pkg rm` for that.

## Notes

- The installer may request your password for privileged operations.
- On conflicts the installer backs up the existing file to `~/.dotfiles-backup/<timestamp>/` and the repository version replaces it. Only files that the repository also contains are affected; other files in the same directories are left alone.
- Review package installation prompts before confirming changes.
- Back up important configuration files before making major changes.
