# arch_root

System configuration files that are copied to `/` (root) rather than symlinked with stow.

## Why not stow?

These files cannot be managed by stow because:

1. **Boot timing** - Files like `vconsole.conf` and systemd units are read early in boot, before the user's home directory is mounted. Symlinks would break.

2. **Root ownership** - These files live in `/etc/` which is owned by root. While `sudo stow` can create symlinks there, having root-owned symlinks point to user-writable files introduces unnecessary complexity.

## Usage

`setup_arch.sh` should copy all necessary files to their proper location.

For example:
```bash
sudo cp ./dotfiles/arch_root/etc/pacman.conf /etc/pacman.conf
```
