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

# Move files in repo to their proper location.
# Symlink config files
sudo pacman -S --noconfirm stow
stow -d dotfiles -t ~ common arch
# Copy these root files
sudo mkdir -p /etc/bluetooth
sudo cp $REPO_ROOT/dotfiles/arch_root/etc/bluetooth/input.conf /etc/bluetooth/input.conf
sudo cp $REPO_ROOT/dotfiles/arch_root/etc/pacman.conf /etc/pacman.conf
sudo cp $REPO_ROOT/dotfiles/arch_root/etc/vconsole.conf /etc/vconsole.conf
# Sync package databases after copying pacman.conf (which may enable new repos like multilib).
sudo pacman -Sy

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
    bat \
    bottom \
    coreutils \
    curl \
    direnv \
    fd \
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
    pyenv \
    ripgrep \
    tldr \
    tmux \
    wget \
    zoxide \
    zsh

# Audio
sudo pacman -S --needed --noconfirm \
    pipewire \
    pipewire-alsa \
    pipewire-pulse \
    wireplumber

# Bluetooth
sudo pacman -S --needed --noconfirm \
    bluez \
    bluez-utils \
    bluetui \
    impala

# Networking
sudo pacman -S --needed --noconfirm \
    networkmanager

# Desktop / Wayland (install portal provider before niri)
sudo pacman -S --needed --noconfirm \
    xdg-desktop-portal-gnome
sudo pacman -S --needed --noconfirm \
    cliphist \
    fuzzel \
    niri \
    obsidian \
    polkit-gnome \
    power-profiles-daemon \
    swaybg \
    swaylock \
    wezterm \
    wl-clipboard \
    xorg-xwayland \
    xwayland-satellite

# Gaming / Graphics (install providers before steam/lutris)
sudo pacman -S --needed --noconfirm \
    lib32-mesa \
    lib32-vulkan-radeon \
    mesa \
    vulkan-radeon
sudo pacman -S --needed --noconfirm \
    dkms \
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
    cloud-sql-proxy \
    docker \
    k9s \
    kubectl \
    kubectx \
    lazydocker \
    lazygit

sudo systemctl enable --now power-profiles-daemon.service

yay -S --noconfirm aur/1password
gpg --receive-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
yay -S --noconfirm 1password-cli
yay -S --noconfirm google-chrome
yay -S --noconfirm python-poetry
yay -S --noconfirm quickshell-git
yay -S --noconfirm ttf-recursive-nerd
yay -S --noconfirm zen-browser-bin

# claude
curl -fsSL https://claude.ai/install.sh | bash

# kanata
yay -S --noconfirm kanata
sudo mkdir -p /etc/kanata
sudo cp $REPO_ROOT/dotfiles/arch_root/etc/kanata/kanata.kbd /etc/kanata/kanata.kbd
sudo cp $REPO_ROOT/dotfiles/arch_root/etc/systemd/system/kanata.service /etc/systemd/system/kanata.service
sudo systemctl daemon-reload
sudo systemctl enable --now kanata

# xbox controller
yay -S --noconfirm xpadneo-dkms-git
sudo modprobe hid_xpadneo || true
echo hid_xpadneo | sudo tee -a /etc/modules-load.d/xpadneo.conf

# Change default shell to zsh
sudo chsh -s /bin/zsh $USER

echo ""
echo "Setup complete!"
echo "Reboot to finish setup."
echo "`sudo reboot`"
