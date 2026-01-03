#!/bin/zsh

# TODO: figure out how to run this during install.
pacman -S --noconfirm gnome
sudo systemctl enable gdm.service

pacman -S --noconfirm 1password-cli
pacman -S --noconfirm bat
pacman -S --noconfirm bottom
pacman -S --noconfirm cloud-sql-proxy
# claude
pacman -S --noconfirm nodejs
pacman -S --noconfirm npm
curl -fsSL https://claude.ai/install.sh | bash
# end claude
pacman -S --noconfirm coreutils
pacman -S --noconfirm curl
pacman -S --noconfirm docker
pacman -S --noconfirm fd
pacman -S --noconfirm fzf
pacman -S --noconfirm git
pacman -S --noconfirm github-cli
pacman -S --noconfirm git-delta
pacman -S --noconfirm go
# hyprland
pacman -S --noconfirm kitty
pacman -S --noconfirm hyprland
pacman -S --noconfirm hyprpaper
pacman -S --noconfirm waybar
pacman -S --noconfirm wofi
# end hyprland
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
pacman -S --noconfirm obsidian
pacman -S --noconfirm owenthereal/upterm/upterm  # See https://github.com/owenthereal/upterm/issues/135 if you are having issues with `upterm host`
pacman -S --noconfirm pspg
pacman -S --noconfirm pyenv
pacman -S --noconfirm ripgrep
# tmuxinator
pacman -S ruby base-devel
gem install tmuxinator
gem install erb
mkdir -p "${XDG_CONFIG_HOME}/tmuxinator"
# end tmuxinator
pacman -S --noconfirm steam
pacman -S --noconfirm stow
pacman -S --noconfirm tldr
pacman -S --noconfirm tmux
pacman -S --noconfirm wget
# Fonts
sudo pacman -S $(pacman -Sgq nerd-fonts)
pacman -Qg nerd-fonts
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

yay -S aur/1password
gpg --receive-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
yay -S 1password-cli
yay -S ttf-recursive-nerd
yay -S python-poetry

# Create environment variables directory.
mkdir -p $ENV_DIR
