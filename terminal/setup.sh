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
fi

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
brew install pyenv
brew install pyenv-virtualenv
brew install lazygit
brew install lazydocker
brew install k9s
brew install fd
brew install tig
brew install htop
brew install node
brew install node@16
brew install lua
brew install ripgrep
brew install jq
brew install ttyrec
brew install rlwrap
brew install lf
brew install kubectl
brew install kubectx
brew install showkey
brew install pspg
brew install diff-so-fancy
brew install deno

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
mkdir -p $HOME/Developer/scratch/notes
mkdir -p $HOME/Developer/scratch/src

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

mkdir -p ~/.config/alacritty
ln -vfF "${SCRIPT_DIR}/dotfiles/alacritty.yml" "${HOME}/.config/alacritty/alacritty.yml"

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

# zsh plugins
brew install zsh-vi-mode
brew install pure
brew install zsh-completions
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install zsh-history-substring-search
chmod -R go-w $(brew --prefix)/share/zsh
