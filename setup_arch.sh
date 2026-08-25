#!/bin/bash

# Arch Linux setup script for a fresh install.
#
# This script:
#   - Symlinks dotfiles to ~ using stow (common + arch)
#   - Copies root config files (bluetooth, pacman, vconsole)
#   - Installs yay (AUR helper)
#   - Installs packages via pacman/yay
#   - Sets zsh as the default shell
#
# NOTE: Must be bash since it runs on a fresh install before zsh is available.

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create any directories you'll need.
# NOTE: This is important since stow will "fold" directories if they don't already exist.
mkdir -p $HOME/.config
mkdir -p $HOME/.config/noctalia
mkdir -p $HOME/.config/niri
mkdir -p $HOME/.local/state/noctalia
mkdir -p $HOME/.local/bin
mkdir -p $HOME/Documents
mkdir -p $HOME/Downloads
# ~/.claude must be a real directory, not a folded symlink into this repo --
# Claude Code writes credentials, session history, and project state into it,
# and only settings.json belongs under version control.
mkdir -p $HOME/.claude
# ~/.ssh must be a real directory, not a folded symlink into this repo --
# the bootstrap repo's github_ssh.sh writes a private key into it.
mkdir -p $HOME/.ssh
chmod 700 $HOME/.ssh

# Move files in repo to their proper location.
# Symlink config files
sudo pacman -S --noconfirm stow
stow -d "$REPO_ROOT/dotfiles" -t ~ common arch
# Copy these root files
sudo mkdir -p /etc/bluetooth
sudo cp $REPO_ROOT/dotfiles/arch_root/etc/bluetooth/input.conf /etc/bluetooth/input.conf
sudo cp $REPO_ROOT/dotfiles/arch_root/etc/pacman.conf /etc/pacman.conf
sudo cp $REPO_ROOT/dotfiles/arch_root/etc/vconsole.conf /etc/vconsole.conf
# Sync package databases after copying pacman.conf (which may enable new repos
# like multilib). -Syu rather than -Sy: syncing without also upgrading leaves
# the system in a partial-upgrade state, where everything installed below links
# against libraries the machine doesn't have yet.
sudo pacman -Syu --noconfirm

# yay
sudo pacman -S --needed --noconfirm base-devel git
if [[ ! -d "$HOME/yay" ]]; then
    git clone https://aur.archlinux.org/yay.git "$HOME/yay"
fi
cd "$HOME/yay"
makepkg -si --noconfirm
cd "$REPO_ROOT"

# Fonts
sudo pacman -S --needed --noconfirm \
    $(pacman -Sgq nerd-fonts) \
    terminus-font

# Core tools
sudo pacman -S --needed --noconfirm \
    alacritty \
    bat \
    bottom \
    clang \
    coreutils \
    chafa \
    curl \
    direnv \
    fd \
    firefox \
    fzf \
    git \
    git-delta \
    github-cli \
    go \
    jq \
    less \
    lsd \
    lua \
    neovim \
    ripgrep \
    tldr \
    tmux \
    uv \
    wget \
    zoxide \
    zsh

# Audio
# lsp-plugins-lv2 supplies the equalizer/compressor/limiter the EasyEffects
# presets are built from; kconfig supplies kwriteconfig6, used just below.
sudo pacman -S --needed --noconfirm \
    easyeffects \
    kconfig \
    lsp-plugins-lv2 \
    pipewire \
    pipewire-alsa \
    pipewire-pulse \
    wireplumber

# EasyEffects speaker EQ.
#
# The presets and their per-route autoload bindings are stowed from the repo
# (~/.local/share/easyeffects/{output,autoload/output}), but this setting lives
# in EasyEffects' own db, which the app rewrites on every exit to record window
# size and preset-use counters. Stowing that file would mean constant churn in
# the repo, so it gets set here instead.
#
# Without the fallback, EasyEffects keeps the *last loaded* preset when a device
# has no autoload binding, which leaks the speaker EQ onto HDMI/USB/Bluetooth
# outputs. With it, only the built-in "Speakers" route gets the EQ and every
# other output gets the empty "neutral" preset.
mkdir -p ~/.config/easyeffects/db
kwriteconfig6 --file ~/.config/easyeffects/db/easyeffectsrc \
    --group Window --key outputAutoloadingUsesFallback true
kwriteconfig6 --file ~/.config/easyeffects/db/easyeffectsrc \
    --group Window --key outputAutoloadingFallbackPreset neutral

# Bluetooth
sudo pacman -S --needed --noconfirm \
    bluez \
    bluez-utils

sudo usermod -aG input $USER

sudo systemctl enable --now bluetooth.service

# Displays
sudo pacman -S --needed --noconfirm \
    brightnessctl

# Printing
sudo pacman -S --needed --noconfirm \
    cups \
    cups-filters

sudo systemctl enable --now cups.service

# Networking
sudo pacman -S --needed --noconfirm \
    networkmanager

# Use iwd as NetworkManager's wifi backend (iwd installed by archinstall).
sudo mkdir -p /etc/NetworkManager/conf.d
sudo cp $REPO_ROOT/dotfiles/arch_root/etc/NetworkManager/conf.d/wifi_backend.conf /etc/NetworkManager/conf.d/wifi_backend.conf

# Hand networking from systemd-networkd/systemd-resolved over to NetworkManager.
sudo systemctl disable --now systemd-networkd.service systemd-networkd.socket systemd-resolved.service 2>/dev/null || true
sudo systemctl enable --now NetworkManager.service

# Desktop / Wayland (install portal provider before niri)
sudo pacman -S --needed --noconfirm \
    xdg-desktop-portal-gnome
sudo pacman -S --needed --noconfirm \
    niri \
    obsidian \
    polkit-gnome \
    power-profiles-daemon \
    wezterm \
    wl-clipboard \
    xorg-xwayland \
    xwayland-satellite

# Login manager (greetd + tuigreet, launches niri-session on vt1)
sudo pacman -S --needed --noconfirm \
    greetd \
    greetd-tuigreet
sudo mkdir -p /etc/greetd
sudo cp $REPO_ROOT/dotfiles/arch_root/etc/greetd/config.toml /etc/greetd/config.toml
sudo systemctl enable greetd.service

# Quiet the boot console so kernel/udev messages don't clutter the greeter.
# Patches systemd-boot loader entries in place; idempotent on re-run.
if ls /boot/loader/entries/*.conf >/dev/null 2>&1; then
    sudo sed -i -e '/^options/{/ quiet /!s| root=| quiet loglevel=3 rd.udev.log_level=3 vt.global_cursor_default=0 root=|}' \
        /boot/loader/entries/*.conf
fi

# Gaming / Graphics (install providers before steam/lutris)
sudo pacman -S --needed --noconfirm \
    lib32-mesa \
    lib32-vulkan-radeon \
    mesa \
    vulkan-radeon
sudo pacman -S --needed --noconfirm \
    lib32-alsa-plugins \
    lib32-pipewire \
    libva-mesa-driver \
    libva-utils \
    linux-headers \
    lutris \
    mesa-utils \
    spotify-launcher \
    steam \
    vulkan-tools \
    wine

# Containers / Kubernetes
sudo pacman -S --needed --noconfirm \
    docker \
    docker-compose \
    k9s \
    kubectl \
    kubectx \
    lazydocker \
    lazygit
    # cloud-sql-proxy

sudo systemctl enable docker.service
sudo usermod -aG docker $USER

sudo systemctl enable --now power-profiles-daemon.service

yay -S --noconfirm aur/1password
gpg --receive-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
yay -S --noconfirm 1password-cli
yay -S --noconfirm google-chrome
yay -S --noconfirm noctalia-git
yay -S --noconfirm ttf-recursive-nerd
yay -S --noconfirm zen-browser-bin

# Default browser
xdg-settings set default-web-browser zen-browser.desktop

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install tree-sitter-cli

# claude
curl -fsSL https://claude.ai/install.sh | bash

# kanata
# Runs as a *user* service so the config can be a stow symlink into this repo
# (a system service starts before login, when ~ may not be available yet).
# Needs read on /dev/input/* (the input group) and write on /dev/uinput, which
# logind grants the logged-in user via ACL. Trade-off: no remapping at the
# greeter, only once logged in.
yay -S --noconfirm kanata
sudo usermod -aG input $USER
systemctl --user daemon-reload
systemctl --user enable --now kanata

# Supernote
# Android / sideloading
sudo pacman -S --needed --noconfirm \
    android-tools \
    android-udev

sudo usermod -aG adbusers $USER

# Change default shell to zsh
sudo chsh -s /bin/zsh $USER

echo ""
echo "Setup complete!"
