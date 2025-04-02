#!/bin/zsh

# TODO: figure out how to run this during install.
pacman -S --noconfirm gnome
sudo systemctl enable gdm.service

pacman -S --noconfirm 1password-cli
pacman -S --noconfirm aichat
pacman -S --noconfirm bat
pacman -S --noconfirm bottom
pacman -S --noconfirm cloud-sql-proxy
pacman -S --noconfirm coreutils
pacman -S --noconfirm curl
pacman -S --noconfirm fd
pacman -S --noconfirm fzf
pacman -S --noconfirm git
pacman -S --noconfirm github-cli
pacman -S --noconfirm git-delta
pacman -S --noconfirm go
pacman -S --noconfirm jq
pacman -S --noconfirm k9s
pacman -S --noconfirm kubectl
pacman -S --noconfirm kubectx
pacman -S --noconfirm kubetui
pacman -S --noconfirm lazydocker
pacman -S --noconfirm lazygit
pacman -S --noconfirm lsd
pacman -S --noconfirm lua
pacman -S --noconfirm neovim
pacman -S --noconfirm owenthereal/upterm/upterm  # See https://github.com/owenthereal/upterm/issues/135 if you are having issues with `upterm host`
pacman -S --noconfirm pspg
pacman -S --noconfirm ripgrep
pacman -S --noconfirm stow
pacman -S --noconfirm tldr
pacman -S --noconfirm tmux
pacman -S --noconfirm wget
# Fonts
pacman -Qg font-caskaydia-mono-nerd-font
pacman -Qg font-departure-mono-nerd-font
pacman -Qg font-fira-mono-nerd-font
pacman -Qg font-gohufont-nerd-font
pacman -Qg font-hack-nerd-font
pacman -Qg font-inconsolata-go-nerd-font
pacman -Qg font-jetbrains-mono-nerd-font
pacman -Qg font-martian-mono-nerd-font
pacman -Qg font-recursive-mono-nerd-font
pacman -Qg font-terminess-ttf-nerd-font
# Applications
# pacman -S --cask 1password
# pacman -S --cask alfred
# pacman -S --cask blackhole-2ch
# pacman -S --cask boom
# pacman -S --cask ghostty
# pacman -S --cask google-chrome
# pacman -S --cask karabiner-elements
# pacman -S --cask obsidian
# pacman -S --cask rancher
# pacman -S --cask rectangle
# pacman -S --cask shifty
# pacman -S --cask spotify
# pacman -S --cask wezterm@nightly


# Symlink config files
stow dotfiles

# Source zshrc to get access to environment variables.
chsh -s /bin/zsh  # Move this to arch installation
source ~/.zshrc

# yay
git clone https://aur.archlinux.org/yay.git $HOME/yay
cd $HOME/yay
makepkg -si

yay tmuxinator
mkdir -p "${XDG_CONFIG_HOME}/tmuxinator"
yay -S aur/1password
gpg --receive-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
yay -S 1password-cli
yay -S ttf-recursive-nerd
yay -S npm
yay -S python-poetry
yay -S rancher-desktop

# Create environment variables directory.
mkdir -p $ENV_DIR
