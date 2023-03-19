#!/bin/zsh

# Command Line Tools
which -s xcode-select
if [[ $? != 0 ]] ; then
    xcode-select --install
else
    echo "Command Line Tools already installed"
fi

# Install Homebrew
which -s brew
if [[ $? != 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
fi

# Applications
read -qs "tf?Install applications? ('y' to install, any other key to skip)"
if [[ "$tf" =~ ^[Yy]$ ]]
then
    brew install --cask alacritty
    brew install --cask docker
    brew install --cask google-chrome
    brew install --cask firefox
    brew install --cask karabiner-elements
    brew install --cask alfred
    brew install --cask rectangle
    brew install --cask shifty
fi

brew install coreutils
brew install tmux
brew install tmate
brew install tmuxinator
brew install ninja
brew install libtool
brew install automake
brew install cmake
brew install pkg-config
brew install gettext
brew install curl
brew install fzf
brew install wget
brew install go
brew install php
brew install composer
brew install lazygit
brew install lazydocker
brew install k9s
brew install fd
brew install htop
brew install node
brew install node@16
npm i -g alacritty-themes
brew install lua
brew install ripgrep
brew install jq
brew install ttyrec
brew install rlwrap
brew install lf
curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example -o ~/.config/lf/icons
brew install kubectl
brew install kubectx
brew install pspg
brew install diff-so-fancy
brew install deno
brew install pyenv
brew install pyenv-virtualenv
brew install libpq
brew link --force libpq

# Fonts
brew tap homebrew/cask-fonts
brew install --cask font-sauce-code-pro-nerd-font
brew install --cask font-hack-nerd-font
brew install --cask font-fira-code-nerd-font
brew install --cask font-jetbrains-mono-nerd-font

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# chatgpt cli
cargo install --force aichat

# Create bin directory
# All custom scripts should be put here
mkdir -p "$HOME/.local/bin"

# Create the compdef directory
# All custom compdef files should be put here
mkdir -p "$HOME/.zsh/compdef"

# Create commonly used directories
mkdir -p $HOME/Developer

# Symlink config files
SCRIPT_DIR=${0:a:h}
mkdir -p ~/.config/alacritty
ln -svfF "${SCRIPT_DIR}/dotfiles/alacritty.yml" "${HOME}/.config/alacritty/alacritty.yml"
ln -svfF "${SCRIPT_DIR}/dotfiles/zshrc" "${HOME}/.zshrc"
ln -svfF "${SCRIPT_DIR}/dotfiles/tmux.conf" "${HOME}/.tmux.conf"
ln -svfF "${SCRIPT_DIR}/dotfiles/tmate.conf" "${HOME}/.tmate.conf"
ln -svfF "${SCRIPT_DIR}/dotfiles/karabiner.json" "${HOME}/.config/karabiner/karabiner.json"
ln -svfF "${SCRIPT_DIR}/dotfiles/gitconfig" "${HOME}/.gitconfig"
ln -svfF "${SCRIPT_DIR}/dotfiles/lazygit.yml" "${HOME}/.config/lazygit/config.yml"
ln -svfF "${SCRIPT_DIR}/dotfiles/lfrc" "${HOME}/.config/lf/lfrc"
ln -svfF "${SCRIPT_DIR}/dotfiles/psqlrc" "${HOME}/.psqlrc"
ln -svfF "${SCRIPT_DIR}/dotfiles/pspgconf" "${HOME}/.pspgconf"

# Source zshrc so plugins are installed automatically.
source ${HOME}/.zshrc

# cloud-sql-proxy
brew install --cask google-cloud-sdk

CPU=$(sysctl -n machdep.cpu.brand_string)
CLOUD_SQL_PROXY_PATH=$HOME/.local/bin/cloud_sql_proxy 

if [[ $CPU =~ ^Apple ]]; then
    curl -o $CLOUD_SQL_PROXY_PATH https://dl.google.com/cloudsql/cloud_sql_proxy.darwin.arm64
    chmod +x $CLOUD_SQL_PROXY_PATH
elif [[ $CPU =~ ^Intel ]]; then
    curl -o $CLOUD_SQL_PROXY_PATH https://dl.google.com/cloudsql/cloud_sql_proxy.darwin.amd64
    chmod +x $CLOUD_SQL_PROXY_PATH
else
    echo "WARNING: could not determine which cloud-sql-proxy version to install."
fi

# alacritty color schemes
git clone https://github.com/eendroroy/alacritty-theme.git ~/.alacritty-colorscheme

# Show task switcher on all monitors.
defaults write com.apple.Dock appswitcher-all-displays -bool true
killall Dock

################
# Setup Neovim #
################
NVIM_REPO_PATH="$HOME/.nvim/neovim"
NVIM_PLUGINS_PATH="$HOME/.nvim/plugins"  # empty directory where plugins can be installed and tested locally.
NVIM_INSTALL_DIR_PATH="$HOME/.local/bin/neovim"

mkdir -p $NVIM_PLUGINS_PATH
mkdir -p $NVIM_INSTALL_DIR_PATH

# Build Prerequisites
brew install --quiet ninja libtool automake cmake pkg-config gettext curl

# Clone or pull the neovim repo
git clone git@github.com:neovim/neovim.git $NVIM_REPO_PATH 2> /dev/null || git -C $NVIM_REPO_PATH pull

# Remove any files that neovim may have created previously
sudo rm -rf "$HOME/.local/share/nvim"

# Install neovim
cd $NVIM_REPO_PATH && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make distclean
sudo make install

# link nvim config
ln -svfF $SCRIPT_DIR/dotfiles/nvim $HOME/.config/nvim

# Let nvim set itself up now that the config has been linked
nvim --headless "+Lazy! sync" +qa
