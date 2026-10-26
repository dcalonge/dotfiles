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
- **System configuration:** Copies everything in `system/` into `/etc`, backing up any file it replaces, and installs private paths `0600`.
- **Networking:** Enables `iwd`, `systemd-networkd`, and `systemd-resolved`, points `/etc/resolv.conf` at the systemd stub, and disables `NetworkManager`, `wpa_supplicant`, and `dhcpcd` if they are present.
- **Login and shell:** Reloads systemd, enables `getty@tty1` for the password-only drop-in, and re-points `/usr/bin/sh` at `dash` in addition to installing the hook that keeps it there.

## Repository structure

```text
dotfiles/
├── install
├── pkglist.txt
├── README.md
├── assets/
├── home/                 # Stow package: mirrors $HOME
│   ├── .bashrc
│   ├── .bash_profile
│   ├── .config/
│   └── .local/
│       └── bin/
├── lib/
│   └── system.sh         # helpers shared by install and sys
└── system/               # mirrors the filesystem root; copied into /etc
    └── etc/
        ├── iwd/
        │   └── main.conf
        ├── pacman.d/
        │   └── hooks/
        │       └── dash-symlink.hook
        └── systemd/
            ├── network/
            │   ├── 10-wired.network
            │   └── 20-wifi.network
            └── system/
                └── getty@tty1.service.d/
                    └── skip-username.conf
```

Everything inside `home/` is a mirror of your home directory and is symlinked into `$HOME`. Everything inside `system/` is a mirror of the filesystem root and is copied into `/etc`. Everything inside `lib/` is shared code, sourced by both the installer and `sys`.

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

## System configuration

Files under `system/` mirror the filesystem root and are installed to `/etc` by the installer. Networking on this setup is:

| Service | Role |
| --- | --- |
| `iwd` | Associates with Wi-Fi. `EnableNetworkConfiguration=false` in `main.conf`, so it leaves addressing to `systemd-networkd`. |
| `systemd-networkd` | Applies `10-wired.network` and `20-wifi.network` and runs DHCP. |
| `systemd-resolved` | Receives DNS from `networkd` and serves the `/etc/resolv.conf` stub. |

Both `.network` files use `DHCP=yes` plus `IPv6AcceptRA=yes`. The wired link has a lower route metric (`100`) than Wi-Fi (`600`), so a plugged-in cable is preferred and Wi-Fi keeps working as a backup.

Unlike `home/`, these files are **copied**, not symlinked. `iwd` and `systemd-networkd` read them at early boot, possibly before `$HOME` is mounted; a symlink into the repository would dangle there and leave the machine without networking. The catch is that editing a file in `system/` only takes effect after rerunning `./install`.

Deployment is idempotent: files that already match are skipped, anything being replaced is copied to `~/.dotfiles-backup/<timestamp>/etc/...` first, and the files are installed `root:root` mode `644`.

Removing a file from `system/` does **not** delete the copy in `/etc`; delete it by hand if that is what you want. This is the opposite of `home/`, where deleting the repository file leaves a dangling symlink behind.

Modes are not always `644`. Files listed in `SYSTEM_PRIVATE_PATHS` in `lib/system.sh` are installed `0600` instead, because git cannot record permission bits beyond the executable flag: a config holding a key or password would otherwise land world-readable in `/etc`. `etc/wireguard` is already listed; add the path of anything else private before you commit it.

### Applying system changes

Unlike `home/`, editing a file in `system/` does nothing until it is applied:

```bash
sys diff      # what differs from /
sys apply     # install it (same as ./install --system-only)
sys list      # files managed by this repository
```

`sys diff` exits non-zero when something has drifted, so it works as a check you can run on a whim. It compares contents, mode and owner, so a file that is right but `644` where it should be `600` is reported too.

`./install --system-only` skips prerequisites, packages and Stow: it only redeploys `system/` and refreshes the networking services. It still uses `sudo`.

### Adding system configuration

1. Put the file in `system/` at the same path it has under `/`:

   ```bash
   mkdir -p ~/dotfiles/system/etc/foo
   sudo cp /etc/foo/bar.conf ~/dotfiles/system/etc/foo/bar.conf
   sudo chown "$USER:$USER" ~/dotfiles/system/etc/foo/bar.conf
   ```

2. Apply it with `sys apply` (or rerun `./install`).
3. Verify with `diff /etc/foo/bar.conf ~/dotfiles/system/etc/foo/bar.conf`.

Commit these files as your user. If you copied them out of `/etc` with `sudo`, they are owned by root and cannot be edited without sudo, so pass them through `chown` as in step 1.

### Connecting to Wi-Fi

`iwd` provides its own client, so no NetworkManager applet is needed:

```bash
iwctl station wlan0 scan              # optional
iwctl station wlan0 connect "SSID"    # prompts for the passphrase
iwctl station wlan0 show              # confirm it is connected
networkctl status                     # confirm networkd leased an address
resolvectl status                     # confirm DNS
```

Credentials are stored by `iwd` as system connection profiles, not in this repository.

### Login on tty1

`system/etc/systemd/system/getty@tty1.service.d/skip-username.conf` replaces agetty's command line with `--skip-login`, so tty1 asks for a password only and never for a username:

```ini
ExecStart=-/usr/bin/agetty -o '-- daniel' --skip-login --noreset --noclear - ${TERM}
```

The username is hard-coded, so change it if you are not `daniel`. Because the drop-in modifies an instance, the installer also enables `getty@tty1.service` — otherwise the drop-in would exist on a fresh system with nothing to apply it to. It never restarts that unit: restarting agetty on tty1 would kill the session you are installing from, so the change takes effect the next time agetty starts (normally a reboot). The installer only reloads systemd.

### `/bin/sh` points at dash

`system/etc/pacman.d/hooks/dash-symlink.hook` re-points `/usr/bin/sh` to dash whenever bash is installed or upgraded:

```ini
[Trigger]
Type = Package
Operation = Install
Operation = Upgrade
Target = bash

[Action]
Description = Re-pointing /bin/sh symlink to dash...
When = PostTransaction
Exec = /usr/bin/ln -sfT dash /usr/bin/sh
Depends = dash
```

The trigger is `bash`, not `dash`, because bash owns `/usr/bin/sh`; a bash upgrade is what silently puts the symlink back. A hook only fires on those package transactions, so the installer also runs the same `ln -sfT dash /usr/bin/sh` (when dash is installed) to make a fresh install match immediately. Scripts that assume bash-only syntax under `sh` will fail here — that is the point of the hook, not a bug.

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
- **Networking setup can interrupt your connection.** Enabling `iwd` and `systemd-networkd` and disabling `NetworkManager`/`wpa_supplicant` will drop whatever is currently handling the network. Everything after that point in the installer is local work, but do not run it over a remote session you cannot reconnect to. If a Wi-Fi config file changed, `iwd` is restarted, which drops the association; reconnect with `iwctl`.
- On conflicts the installer backs up the existing file to `~/.dotfiles-backup/<timestamp>/` and the repository version replaces it. Only files that the repository also contains are affected; this applies to both `$HOME` and `/etc`.
- Review package installation prompts before confirming changes.
- Back up important configuration files before making major changes.
