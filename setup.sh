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

brew install aichat
brew install automake
brew install bat
brew install bottom
brew install cmake
brew install composer
brew install coreutils
brew install curl
brew install deno
brew install diff-so-fancy
brew install fd
brew install fzf
brew install fzy
brew install gettext
brew install go
brew install htop
brew install jq
brew install k9s
brew install kubectl
brew install kubectx
brew install lazydocker
brew install lazygit
brew install libpq
brew link --force libpq
brew install libtool
brew install lsd
brew install lua
brew install neovim
brew install ninja
brew install node
brew install octave
brew install php
brew install pkg-config
brew install pspg
brew install pyenv
brew install pyenv-virtualenv
brew install ripgrep
brew install rlwrap
brew install sk
brew install tmate
brew install tmux
brew install tmuxinator
brew install ttyrec
brew install wget
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install zsh-vi-mode

# Fonts
brew tap homebrew/cask-fonts
brew install --cask font-fira-code-nerd-font
brew install --cask font-gohufont-nerd-font
brew install --cask font-hack-nerd-font
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-sauce-code-pro-nerd-font
brew tap shaunsingh/SFMono-Nerd-Font-Ligaturized
brew install --cask font-sf-mono-nerd-font-ligaturized

# Applications
brew install --cask alacritty
brew install --cask alfred
brew install --cask docker
brew install --cask karabiner-elements
brew install --cask rectangle
brew install --cask shifty

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Create the compdef directory
# All custom compdef files should be put here
mkdir -p "$HOME/.zsh/compdef"
mkdir -p "$HOME/.zsh/funcs"

# Create commonly used directories
mkdir -p $HOME/Developer

# Symlink config files
SCRIPT_DIR=${0:a:h}

mkdir -p ~/.config/alacritty
ln -svfF "${SCRIPT_DIR}/dotfiles/alacritty/themes/" "${XDG_CONFIG_HOME}/alacritty/themes"

ln -svfF "${SCRIPT_DIR}/dotfiles/zshrc"                  "${HOME}/.zshrc"
ln -svfF "${SCRIPT_DIR}/dotfiles/gitconfig"              "${HOME}/.gitconfig"
ln -svfF "${SCRIPT_DIR}/dotfiles/psqlrc"                 "${HOME}/.psqlrc"
ln -svfF "${SCRIPT_DIR}/dotfiles/pspgconf"               "${HOME}/.pspgconf"
ln -svfF "${SCRIPT_DIR}/dotfiles/octaverc"               "${HOME}/.octaverc"
mkdir -p                                                 "${HOME}/.zsh/funcs"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/find_file"        "${HOME}/.zsh/funcs/find_file"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/alacritty_config" "${HOME}/.zsh/funcs/alacritty_config"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/font_picker"      "${HOME}/.zsh/funcs/font_picker"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/nvim_open"        "${HOME}/.zsh/funcs/nvim_open"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/psqlp"            "${HOME}/.zsh/funcs/psqlp"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/select_session"   "${HOME}/.zsh/funcs/select_session"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/theme_picker"     "${HOME}/.zsh/funcs/theme_picker"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/tse"              "${HOME}/.zsh/funcs/tse"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/aichat_config"    "${HOME}/.zsh/funcs/aichat_config"

ln -svfF "${SCRIPT_DIR}/dotfiles/alacritty.toml.template"  "${XDG_CONFIG_HOME}/alacritty/alacritty.toml.template"
ln -svfF "${SCRIPT_DIR}/dotfiles/karabiner.json"           "${XDG_CONFIG_HOME}/karabiner/karabiner.json"
ln -svfF "${SCRIPT_DIR}/dotfiles/lazygit.yml"              "${XDG_CONFIG_HOME}/lazygit/config.yml"
mkdir -p                                                   "${XDG_CONFIG_HOME}/lsd"
ln -svfF "${SCRIPT_DIR}/dotfiles/lsd/config.yaml"          "${XDG_CONFIG_HOME}/lsd/config.yaml"
ln -svfF "${SCRIPT_DIR}/dotfiles/lsd/colors.yaml"          "${XDG_CONFIG_HOME}/lsd/colors.yaml"
mkdir -p                                                   "${XDG_CONFIG_HOME}/nvim"
ln -svfF "${SCRIPT_DIR}/dotfiles/nvim"                     "${XDG_CONFIG_HOME}/nvim"
mkdir -p                                                   "${XDG_CONFIG_HOME}/tmux"
ln -svfF "${SCRIPT_DIR}/dotfiles/tmux.conf"                "${XDG_CONFIG_HOME}/tmux/tmux.conf"
ln -svfF "${SCRIPT_DIR}/dotfiles/nord-status-content.conf" "${XDG_CONFIG_HOME}/tmux/plugins/tmux/src/nord-status-content.conf"
source-file                                                "${XDG_CONFIG_HOME}/tmux/plugins/tmux/src/nord-status-content.conf"

# AiChat - TODO: set this up in XDG_CONFIG_HOME
mkdir -p                                                      "${HOME}/Library/Application Support/aichat"
ln -svfF "${SCRIPT_DIR}/dotfiles/aichat_config.yaml.template" "${HOME}/Library/Application Support/aichat/aichat_config.yaml.template"

# Obsidian
ln -svfF "${SCRIPT_DIR}/dotfiles/obsidian.vimrc" "${HOME}/Documents/notes/notes/.obsidian.vimrc"

# Let nvim set itself up now that the config has been linked
nvim --headless "+Lazy! sync" +qa

# Source zshrc so plugins are installed automatically.
source ${HOME}/.zshrc

# cloud-sql-proxy
brew install --cask google-cloud-sdk
CPU=$(sysctl -n machdep.cpu.brand_string)
mkdir -p "$HOME/.local/bin"
CLOUD_SQL_PROXY_PATH=usr/local/bin/cloud_sql_proxy
if [[ $CPU =~ ^Apple ]]; then
    curl -o $CLOUD_SQL_PROXY_PATH https://dl.google.com/cloudsql/cloud_sql_proxy.darwin.arm64
    chmod +x $CLOUD_SQL_PROXY_PATH
elif [[ $CPU =~ ^Intel ]]; then
    curl -o $CLOUD_SQL_PROXY_PATH https://dl.google.com/cloudsql/cloud_sql_proxy.darwin.amd64
    chmod +x $CLOUD_SQL_PROXY_PATH
else
    echo "WARNING: could not determine which cloud-sql-proxy version to install."
fi

# Show task switcher on all monitors.
defaults write com.apple.Dock appswitcher-all-displays -bool true
killall Dock
