#!/bin/zsh

# Command Line Tools
which -s xcode-select
if [[ $? != 0 ]] ; then
    xcode-select --install
else
    echo "Command Line Tools already installed"
fi

# Show task switcher on all monitors.
defaults write com.apple.Dock appswitcher-all-displays -bool true
killall Dock

# Install Homebrew
which -s brew
if [[ $? != 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ln -svfF "${SCRIPT_DIR}/dotfiles/zprofile" "${HOME}/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    brew update
fi

# CLI
brew install aichat
brew install automake
brew install bat
brew install bottom
brew install cmake
brew install composer
brew install coreutils
brew install curl
brew install deno
brew install git-delta
brew install fd
brew install fzf
$(brew --prefix)/opt/fzf/install
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
brew install --cask font-caskaydia-mono-nerd-font
brew install --cask font-fira-code-nerd-font
brew install --cask font-gohufont-nerd-font
brew install --cask font-hack-nerd-font
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask homebrew/cask-fonts/font-meslo-lg-nerd-font
brew install --cask font-sauce-code-pro-nerd-font
brew install --cask font-terminess-ttf-nerd-font
brew tap shaunsingh/SFMono-Nerd-Font-Ligaturized
brew install --cask font-sf-mono-nerd-font-ligaturized

# Applications
brew install --cask 1password
brew install --cask alacritty
brew install --cask alfred
brew install --cask docker
brew install --cask karabiner-elements
brew install --cask obsidian
brew install --cask rectangle
brew install --cask shifty
brew install --cask topnotch

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Symlink config files
SCRIPT_DIR=${0:a:h}
mkdir -p                                                  "${HOME}/Developer"
ln -svfF "${SCRIPT_DIR}/dotfiles/obsidian.vimrc"          "${HOME}/Documents/notes/.obsidian.vimrc"  # Needs to be linked again after signing into Obsidian.
ln -svfF "${SCRIPT_DIR}/dotfiles/zshrc"                   "${HOME}/.zshrc"
ln -svfF "${SCRIPT_DIR}/dotfiles/gitconfig.template"      "${HOME}/.gitconfig.template"
ln -svfF "${SCRIPT_DIR}/dotfiles/psqlrc"                  "${HOME}/.psqlrc"
ln -svfF "${SCRIPT_DIR}/dotfiles/pspgconf"                "${HOME}/.pspgconf"
ln -svfF "${SCRIPT_DIR}/dotfiles/octaverc"                "${HOME}/.octaverc"
mkdir -p                                                  "${HOME}/.zsh/funcs"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/alacritty_config"  "${HOME}/.zsh/funcs/alacritty_config"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/aichat_config"     "${HOME}/.zsh/funcs/aichat_config"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/git_config"        "${HOME}/.zsh/funcs/git_config"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/lazygit_config"    "${HOME}/.zsh/funcs/lazygit_config"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/find_file"         "${HOME}/.zsh/funcs/find_file"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/font_picker"       "${HOME}/.zsh/funcs/font_picker"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/macos_appearance"  "${HOME}/.zsh/funcs/macos_appearance"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/nvim_open"         "${HOME}/.zsh/funcs/nvim_open"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/psqlp"             "${HOME}/.zsh/funcs/psqlp"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/select_session"    "${HOME}/.zsh/funcs/select_session"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/theme_picker"      "${HOME}/.zsh/funcs/theme_picker"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/tse"               "${HOME}/.zsh/funcs/tse"
mkdir -p                                                  "${XDG_CONFIG_HOME}/alacritty"
ln -svfF "${SCRIPT_DIR}/dotfiles/alacritty/themes/"       "${XDG_CONFIG_HOME}/alacritty/themes"
ln -svfF "${SCRIPT_DIR}/dotfiles/alacritty.toml.template" "${XDG_CONFIG_HOME}/alacritty/alacritty.toml.template"
cp       "${SCRIPT_DIR}/dotfiles/karabiner.json"          "${XDG_CONFIG_HOME}/karabiner/karabiner.json"  # Needs to be re-copied if changed. Symlinks don't work for some reason.
ln -svfF "${SCRIPT_DIR}/dotfiles/lazygit.yml.template"    "${XDG_CONFIG_HOME}/lazygit/config.yml.template"
mkdir -p                                                  "${XDG_CONFIG_HOME}/lsd"
ln -svfF "${SCRIPT_DIR}/dotfiles/lsd/config.yaml"         "${XDG_CONFIG_HOME}/lsd/config.yaml"
ln -svfF "${SCRIPT_DIR}/dotfiles/lsd/colors.yaml"         "${XDG_CONFIG_HOME}/lsd/colors.yaml"
ln -svfF "${SCRIPT_DIR}/dotfiles/nvim"                    "${XDG_CONFIG_HOME}/nvim"
mkdir -p                                                  "${XDG_CONFIG_HOME}/tmux"
ln -svfF "${SCRIPT_DIR}/dotfiles/tmux.conf"               "${XDG_CONFIG_HOME}/tmux/tmux.conf"

# AiChat - TODO: set this up in XDG_CONFIG_HOME
mkdir -p                                                      "${HOME}/Library/Application Support/aichat"
ln -svfF "${SCRIPT_DIR}/dotfiles/aichat_config.yaml.template" "${HOME}/Library/Application Support/aichat/aichat_config.yaml.template"
touch                                                         "${HOME}/.openai_api_key"  # Add openai key to this file

# Let nvim set itself up now that the config has been linked
nvim --headless "+Lazy! sync" +qa

# Source zshrc so plugins are installed automatically.
source ${HOME}/.zshrc
