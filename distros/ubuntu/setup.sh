#!/bin/zsh

apt-get update
apt-get install coreutils
apt-get install tmux
apt-get install tmate
apt-get install tmuxinator
apt-get install ninja
apt-get install libtool
apt-get install automake
apt-get install cmake
apt-get install pkg-config
apt-get install gettext
apt-get install curl
apt-get install fzf
apt-get install wget
apt-get install go
apt-get install php
apt-get install composer
apt-get install pyenv
apt-get install pyenv-virtualenv
apt-get install lazygit
apt-get install lazydocker
apt-get install k9s
apt-get install fd
apt-get install tig
apt-get install htop
apt-get install node
apt-get install node@16
apt-get install lua
apt-get install ripgrep
apt-get install jq
apt-get install ttyrec
apt-get install rlwrap
apt-get install lf
apt-get install kubectl
apt-get install kubectx
apt-get install showkey
apt-get install pspg
apt-get install diff-so-fancy
apt-get install deno
apt-get install libpq

# Fonts
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font 
brew install --cask font-fira-code-nerd-font
brew install --cask font-jetbrains-mono-nerd-font

# Rust
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

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
ln -svfF "${SCRIPT_DIR}/dotfiles/zshrc" "${HOME}/.zshrc"
ln -svfF "${SCRIPT_DIR}/dotfiles/tmux.conf" "${HOME}/.tmux.conf"
ln -svfF "${SCRIPT_DIR}/dotfiles/tmate.conf" "${HOME}/.tmate.conf"
ln -svfF "${SCRIPT_DIR}/dotfiles/karabiner.json" "${HOME}/.config/karabiner/karabiner.json"
ln -svfF "${SCRIPT_DIR}/dotfiles/gitconfig" "${HOME}/.gitconfig"
ln -svfF "${SCRIPT_DIR}/dotfiles/lazygit.yml" "${HOME}/Library/Application Support/lazygit/config.yml"
ln -svfF "${SCRIPT_DIR}/dotfiles/psqlrc" "${HOME}/.psqlrc"
ln -svfF "${SCRIPT_DIR}/dotfiles/pspgconf" "${HOME}/.pspgconf"

# Alacritty doesn't like symlinks for some reason.
mkdir -p ~/.config/alacritty
ln -vf "${SCRIPT_DIR}/dotfiles/alacritty.yml" "${HOME}/.config/alacritty/alacritty.yml"

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

###############
# Setup Repos #
###############
REPOS_PROJECT_DIR=$HOME/Developer/repos
mkdir -p $REPOS_PROJECT_DIR

if [[ ! -d "${REPOS_PROJECT_DIR}/.git" ]]; then
    git clone git@github.com:ryanburda/repos.git $REPOS_PROJECT_DIR
fi

cd $REPOS_PROJECT_DIR
./setup.sh
