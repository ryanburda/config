#!/bin/zsh

if [ -z "$XDG_CONFIG_HOME" ]; then
    echo "=============WARNING============="
    echo "== XDG_CONFIG_HOME is not set. =="
    echo "== Reset terminal by running:  =="
    echo "== `reset`                     =="
    echo "================================="
    exit -1
fi

# If config repo is in normal location then this is `SCRIPT_DIR=$HOME/Developer/config`
SCRIPT_DIR=${0:a:h}

# OS specific installations
if [[ $OSTYPE == darwin* ]]; then
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
    brew install utm
    brew install wget
    brew install zsh-autosuggestions
    brew install zsh-syntax-highlighting
    brew install zsh-vi-mode

    # Fonts
    # brew install --cask font-<FONT NAME>-nerd-font
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
    brew install --cask font-iosevka-term-slab-nerd-font
    brew install --cask font-inconsolata-go-nerd-font
    brew install --cask font-zed-mono-nerd-font

    # Applications
    brew install --cask wezterm@nightly
    brew install --cask rancher
    brew install --cask karabiner-elements
    brew install --cask google-chrome
    brew install --cask 1password
    brew install --cask alfred
    brew install --cask obsidian
    brew install --cask rectangle
    brew install --cask shifty
    brew install --cask topnotch
    brew install --cask blackhole-2ch
fi

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Symlink config files
mkdir -p                                                            "${HOME}/Developer"
ln -svfF "${SCRIPT_DIR}/dotfiles/obsidian.vimrc"                    "${HOME}/Documents/notes/.obsidian.vimrc"
ln -svfF "${SCRIPT_DIR}/dotfiles/zshrc"                             "${HOME}/.zshrc"
ln -svfF "${SCRIPT_DIR}/dotfiles/gitconfig.template"                "${HOME}/.gitconfig.template"
ln -svfF "${SCRIPT_DIR}/dotfiles/psqlrc"                            "${HOME}/.psqlrc"
ln -svfF "${SCRIPT_DIR}/dotfiles/pspgconf"                          "${HOME}/.pspgconf"
ln -svfF "${SCRIPT_DIR}/dotfiles/octaverc"                          "${HOME}/.octaverc"
touch                                                               "${HOME}/.openai_api_key"  # Add openai key to this file.
ln -svfF "${SCRIPT_DIR}/dotfiles/zprofile"                          "${HOME}/.zprofile"
mkdir -p                                                            "${HOME}/.zsh/funcs"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/aichat_config"               "${HOME}/.zsh/funcs/aichat_config"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/git_config"                  "${HOME}/.zsh/funcs/git_config"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/lazygit_config"              "${HOME}/.zsh/funcs/lazygit_config"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/font_picker"                 "${HOME}/.zsh/funcs/font_picker"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/dark_mode"                   "${HOME}/.zsh/funcs/dark_mode"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/psqlp"                       "${HOME}/.zsh/funcs/psqlp"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/select_session"              "${HOME}/.zsh/funcs/select_session"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/colorscheme_picker"          "${HOME}/.zsh/funcs/colorscheme_picker"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/background_picker"           "${HOME}/.zsh/funcs/background_picker"
mkdir -p                                                            "${XDG_CONFIG_HOME}/wezterm"
ln -svfF "${SCRIPT_DIR}/dotfiles/wezterm/wezterm.lua"               "${XDG_CONFIG_HOME}/wezterm/wezterm.lua"
ln -svfF "${SCRIPT_DIR}/dotfiles/wezterm/helpers.lua"               "${XDG_CONFIG_HOME}/wezterm/helpers.lua"
ln -svfF "${SCRIPT_DIR}/dotfiles/wezterm/backgrounds"               "${XDG_CONFIG_HOME}/wezterm/backgrounds"
mkdir -p                                                            "${XDG_CONFIG_HOME}/lazygit"
ln -svfF "${SCRIPT_DIR}/dotfiles/lazygit.yml.template"              "${XDG_CONFIG_HOME}/lazygit/config.yml.template"
mkdir -p                                                            "${XDG_CONFIG_HOME}/lsd"
ln -svfF "${SCRIPT_DIR}/dotfiles/lsd/config.yaml"                   "${XDG_CONFIG_HOME}/lsd/config.yaml"
ln -svfF "${SCRIPT_DIR}/dotfiles/lsd/colors.yaml"                   "${XDG_CONFIG_HOME}/lsd/colors.yaml"
ln -svfF "${SCRIPT_DIR}/dotfiles/nvim"                              "${XDG_CONFIG_HOME}/nvim"
mkdir -p                                                            "${XDG_CONFIG_HOME}/sqls"
ln -svfF "${SCRIPT_DIR}/dotfiles/sqls_config.yml"                   "${XDG_CONFIG_HOME}/sqls/config.yml"
mkdir -p                                                            "${XDG_CONFIG_HOME}/tmux"
ln -svfF "${SCRIPT_DIR}/dotfiles/tmux.conf"                         "${XDG_CONFIG_HOME}/tmux/tmux.conf"
mkdir -p                                                            "${XDG_CONFIG_HOME}/aichat"
ln -svfF "${SCRIPT_DIR}/dotfiles/aichat_config.yaml.template"       "${XDG_CONFIG_HOME}/aichat/aichat_config.yaml.template"

# OS specific symlinks
if [[ $OSTYPE == darwin* ]]; then
    # macOS
    # TODO: Find out why this can't be symlined.
    # NOTE: Needs to be re-copied if changed. Symlinks don't work for some reason.
    cp "${SCRIPT_DIR}/dotfiles/karabiner.json" "${XDG_CONFIG_HOME}/karabiner/karabiner.json"
fi

# OS specific settings
if [[ $OSTYPE == darwin* ]]; then
    # Show task switcher on all monitors.
    defaults write com.apple.Dock appswitcher-all-displays -bool true
    killall Dock
fi

# Additional manual steps
cat "${SCRIPT_DIR}/manual_steps.txt"
