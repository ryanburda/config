#!/bin/zsh

# OS
sudo pacman -S --noconfirm fuzzel
sudo pacman -S --noconfirm niri
sudo pacman -S --noconfirm polkit-gnome
sudo pacman -S --noconfirm swaybg
sudo pacman -S --noconfirm swaylock
sudo pacman -S --noconfirm xdg-desktop-portal-gnome
sudo pacman -S --noconfirm xdg-desktop-portal-gtk
sudo pacman -S --noconfirm xorg-xwayland
sudo pacman -S --noconfirm xwayland-satellite

# utils
sudo pacman -S --noconfirm base-devel
sudo pacman -S --noconfirm bat
sudo pacman -S --noconfirm bottom
sudo pacman -S --noconfirm bluetui
sudo pacman -S --noconfirm cloud-sql-proxy
sudo pacman -S --noconfirm cliphist
sudo pacman -S --noconfirm coreutils
sudo pacman -S --noconfirm curl
sudo pacman -S --noconfirm docker
sudo pacman -S --noconfirm fd
sudo pacman -S --noconfirm fzf
sudo pacman -S --noconfirm git
sudo pacman -S --noconfirm github-cli
sudo pacman -S --noconfirm git-delta
sudo pacman -S --noconfirm go
sudo pacman -S --noconfirm impala
sudo pacman -S --noconfirm jq
sudo pacman -S --noconfirm k9s
sudo pacman -S --noconfirm kubectl
sudo pacman -S --noconfirm kubectx
sudo pacman -S --noconfirm lazydocker
sudo pacman -S --noconfirm lazygit
sudo pacman -S --noconfirm less
sudo pacman -S --noconfirm lsd
sudo pacman -S --noconfirm lua
sudo pacman -S --noconfirm networkmanager
sudo pacman -S --noconfirm neovim
sudo pacman -S --noconfirm obsidian
sudo pacman -S --noconfirm pyenv
sudo pacman -S --noconfirm power-profiles-daemon
sudo systemctl enable --now power-profiles-daemon.service
sudo pacman -S --noconfirm ripgrep
sudo pacman -S --noconfirm stow
sudo pacman -S --noconfirm spotify-launcher
sudo pacman -S --noconfirm tldr
sudo pacman -S --noconfirm tmux
sudo pacman -S --noconfirm wezterm
sudo pacman -S --noconfirm wget
sudo pacman -S --noconfirm wl-clipboard

# Fonts
sudo pacman -S --noconfirm $(pacman -Sgq nerd-fonts)
sudo pacman -Qg nerd-fonts
sudo pacman -S --noconfirm terminus-font

# claude
sudo pacman -S --noconfirm nodejs
sudo pacman -S --noconfirm npm
curl -fsSL https://claude.ai/install.sh | bash

# tmuxinator
sudo pacman -S ruby base-devel
gem install tmuxinator
gem install erb

# yay
sudo pacman -S --noconfirm base-devel git
mkdir -p ~/git/Jguer
cd !$
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Apps
yay -S aur/1password
gpg --receive-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
yay -S 1password-cli
yay -S google-chrome
yay -S python-poetry
yay -S quickshell-git
yay -S ttf-recursive-nerd
yay -S zen-browser-bin

# Gaming
# AMD drivers
sudo pacman -S --noconfirm mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver libva-utils vulkan-tools mesa-utils 
# Xbox controller
sudo pacman -S --noconfirm bluez bluez-utils dkms linux-headers
yay -S xpadneo-dkms-git
sudo modprobe hid_xpadneo
echo hid_xpadneo | sudo tee -a /etc/modules-load.d/xpadneo.conf
# Steam
sudo pacman -S --noconfirm wine
sudo pacman -S --noconfirm lutris
sudo pacman -S --noconfirm steam
# Audio
sudo pacman -S pipewire pipewire-pulse wireplumber pipewire-alsa lib32-pipewire lib32-alsa-plugins
# pactl set-default-sink 61
# End Gaming

# Symlink config files
stow dotfiles

# Source zshrc to get access to environment variables.
chsh -s /bin/zsh  # Move this to arch installation
source ~/.zshrc

# Link these non-user files to their correct location
sudo mkdir -p /etc/bluetooth
sudo cp $HOME/config/arch/etc/bluetooth/input.conf /etc/bluetooth/input.conf
sudo cp $HOME/config/arch/etc/pacman.conf /etc/pacman.conf
sudo cp $HOME/config/arch/etc/vconsole.conf /etc/vconsole.conf

# Kanata (Key remaps)
yay -S kanata
sudo mkdir -p /etc/kanata
sudo cp $HOME/config/arch/etc/kanata/kanata.kbd /etc/kanata/kanata.kbd
sudo cp $HOME/config/arch/etc/systemd/system/kanata.service /etc/systemd/system/kanata.service
sudo systemctl daemon-reload
sudo systemctl enable --now kanata

# Create environment variables directory.
mkdir -p $ENV_DIR
