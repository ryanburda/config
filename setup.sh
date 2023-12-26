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
brew install --cask alacritty
brew install --cask docker
brew install --cask karabiner-elements
brew install --cask alfred
brew install --cask rectangle
brew install --cask shifty

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
brew install lsd
brew install bottom
brew install bat
brew install fzf
brew install sk
brew install fzy
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
brew install kubectl
brew install kubectx
brew install pspg
brew install diff-so-fancy
brew install deno
brew install pyenv
brew install pyenv-virtualenv
brew install libpq
brew link --force libpq
brew install octave
brew install aichat
brew install zsh-vi-mode
brew install zsh-syntax-highlighting
brew install zsh-autosuggestions

# Fonts
brew tap homebrew/cask-fonts
brew install --cask font-sauce-code-pro-nerd-font
brew install --cask font-hack-nerd-font
brew install --cask font-fira-code-nerd-font
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-gohufont-nerd-font
brew tap shaunsingh/SFMono-Nerd-Font-Ligaturized
brew install --cask font-sf-mono-nerd-font-ligaturized

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Create bin directory
# All custom scripts should be put here
mkdir -p "$HOME/.local/bin"

# Create the compdef directory
# All custom compdef files should be put here
mkdir -p "$HOME/.zsh/compdef"
mkdir -p "$HOME/.zsh/funcs"

# Create commonly used directories
mkdir -p $HOME/Developer

# Symlink config files
SCRIPT_DIR=${0:a:h}

mkdir -p ~/.config/alacritty

ln -svfF "${SCRIPT_DIR}/dotfiles/zshrc" "${HOME}/.zshrc"
mkdir -p "${HOME}/.zsh/funcs"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/find_file" "${HOME}/.zsh/funcs/find_file"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/set_font" "${HOME}/.zsh/funcs/set_font"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/font_picker" "${HOME}/.zsh/funcs/font_picker"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/nvim_open" "${HOME}/.zsh/funcs/nvim_open"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/psqlp" "${HOME}/.zsh/funcs/psqlp"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/select_session" "${HOME}/.zsh/funcs/select_session"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/theme_picker" "${HOME}/.zsh/funcs/theme_picker"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/tse" "${HOME}/.zsh/funcs/tse"

mkdir -p "${XDG_CONFIG_HOME}/lf"
curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example -o "${XDG_CONFIG_HOME}/lf/icons"
ln -svfF "${SCRIPT_DIR}/dotfiles/lfrc" "${XDG_CONFIG_HOME}/lf/lfrc"

mkdir -p "${XDG_CONFIG_HOME}/tmux"
ln -svfF "${SCRIPT_DIR}/dotfiles/tmux.conf" "${XDG_CONFIG_HOME}/tmux/tmux.conf"
ln -svfF "${SCRIPT_DIR}/dotfiles/alacritty.yml.template" "${XDG_CONFIG_HOME}/alacritty/alacritty.yml.template"
ln -svfF "${SCRIPT_DIR}/dotfiles/karabiner.json" "${XDG_CONFIG_HOME}/karabiner/karabiner.json"
ln -svfF "${SCRIPT_DIR}/dotfiles/lazygit.yml" "${XDG_CONFIG_HOME}/lazygit/config.yml"

ln -svfF "${SCRIPT_DIR}/dotfiles/gitconfig" "${HOME}/.gitconfig"
ln -svfF "${SCRIPT_DIR}/dotfiles/psqlrc" "${HOME}/.psqlrc"
ln -svfF "${SCRIPT_DIR}/dotfiles/pspgconf" "${HOME}/.pspgconf"
ln -svfF "${SCRIPT_DIR}/dotfiles/octaverc" "${HOME}/.octaverc"
ln -svfF "${SCRIPT_DIR}/dotfiles/nord-status-content.conf" "${HOME}/.config/tmux/plugins/tmux/src/nord-status-content.conf"

source-file "${HOME}/.config/tmux/plugins/tmux/src/nord-status-content.conf"

# Obsidian
ln -svfF "${SCRIPT_DIR}/dotfiles/obsidian.vimrc" "${HOME}/Documents/notes/notes/.obsidian.vimrc"

# Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

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
