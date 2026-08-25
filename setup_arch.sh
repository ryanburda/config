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

# Stop at the first failed command. Without this, any failure partway through
# like an unavailable package, a stow conflict, a failed build just scrolls past
# and the script still prints "Setup complete!" at the end, leaving a machine
# that looks set up but isn't. Steps that are expected to fail on a fresh
# install are tolerated explicitly below.
set -eo pipefail
trap 'echo >&2; echo "setup_arch.sh: FAILED at line ${LINENO}: ${BASH_COMMAND}" >&2' ERR

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create any directories you'll need.
# NOTE: This is important since stow will "fold" directories if they don't already exist.
mkdir -p $HOME/.config
mkdir -p $HOME/.config/noctalia
mkdir -p $HOME/.config/niri
mkdir -p $HOME/.local/state/noctalia
mkdir -p $HOME/.local/bin
mkdir -p $HOME/.local/share
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

# ~/.gitconfig must exist, even empty. The static config is stowed to
# ~/.config/git/config, which git reads as a second global file -- but when
# ~/.gitconfig is absent, `git config --global` and `gh auth setup-git` fall
# back to writing ~/.config/git/config instead, which is a symlink into this
# repo. An empty file here keeps every tool write in $HOME.
touch $HOME/.gitconfig

# Move files in repo to their proper location.
# Symlink config files
sudo pacman -S --noconfirm stow
stow -d "$REPO_ROOT/dotfiles" -t ~ common arch
# Copy these root files
sudo mkdir -p /etc/bluetooth
sudo cp $REPO_ROOT/dotfiles/arch_root/etc/bluetooth/input.conf /etc/bluetooth/input.conf
sudo cp $REPO_ROOT/dotfiles/arch_root/etc/pacman.conf /etc/pacman.conf
# Sync package databases after copying pacman.conf (which may enable new repos
# like multilib). -Syu rather than -Sy: syncing without also upgrading leaves
# the system in a partial-upgrade state, where everything installed below links
# against libraries the machine doesn't have yet.
sudo pacman -Syu --noconfirm

# yay
sudo pacman -S --needed --noconfirm base-devel git
if ! command -v yay > /dev/null 2>&1; then
    # yay-bin ships a precompiled binary, so a fresh machine doesn't have to
    # build a Go program first. Built in a temp dir that gets cleaned up rather
    # than a permanent ~/yay, which went stale on every re-run.
    yay_build=$(mktemp -d)
    git clone https://aur.archlinux.org/yay-bin.git "$yay_build"
    (cd "$yay_build" && makepkg -si --noconfirm)
    rm -rf "$yay_build"
fi

# Fonts
sudo pacman -S --needed --noconfirm \
    otf-firamono-nerd \
    terminus-font \
    ttf-cascadia-mono-nerd \
    ttf-gohu-nerd \
    ttf-hack-nerd \
    ttf-inconsolata-go-nerd \
    ttf-jetbrains-mono-nerd \
    ttf-martian-mono-nerd \
    ttf-recursive-nerd \
    ttf-terminus-nerd

# vconsole.conf sets FONT=ter-132b, so it's copied only now that terminus-font
# is installed -- otherwise an initramfs rebuild in between would warn about a
# missing console font.
sudo cp $REPO_ROOT/dotfiles/arch_root/etc/vconsole.conf /etc/vconsole.conf

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
    nodejs \
    npm \
    ripgrep \
    tldr \
    tmux \
    tree-sitter-cli \
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

sudo systemctl enable --now bluetooth.service

# Displays
sudo pacman -S --needed --noconfirm \
    brightnessctl

# Printing
sudo pacman -S --needed --noconfirm \
    cups \
    cups-filters

sudo systemctl enable --now cups.service

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
yay -S --noconfirm 1password-cli
yay -S --noconfirm google-chrome
yay -S --noconfirm noctalia-git
yay -S --noconfirm zen-browser-bin  # Run `xdg-settings set default-web-browser zen.desktop` to make it the default browser.

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
# Non-fatal: the unit cannot actually start until the `input` group membership
# added just above is live, which takes a fresh login. `enable` still sticks, so
# kanata comes up on its own the next time you log in.
if ! systemctl --user daemon-reload || ! systemctl --user enable --now kanata; then
    echo "WARNING: kanata is enabled but could not start yet -- it needs the 'input' group, which applies after you log in again." >&2
fi

# Change default shell to zsh
sudo chsh -s /bin/zsh $USER

echo ""
echo "Setup complete!"
echo "Reboot to finish"
echo ""
