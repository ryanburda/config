#!/bin/zsh

# If config repo is in normal location then this is `SCRIPT_DIR=$HOME/Developer/config`
# The following can be used when testing manually:  `SCRIPT_DIR=$(pwd)`
SCRIPT_DIR=${0:a:h}

# symlink and source environment files so that variables
# can be used throughout the rest of this script.
ln -svfF "${SCRIPT_DIR}/dotfiles/zshrc" "${HOME}/.zshrc"
source ~/.zshrc
ln -svfF "${SCRIPT_DIR}/dotfiles/zprofile" "${HOME}/.zprofile"
source ~/.zprofile

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
        # Source zprofile again now that brew is installed.
        source ~/.zprofile
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
    brew install fd
    brew install fzf
    $(brew --prefix)/opt/fzf/install
    brew install fzy
    brew install gettext
    brew install gh
    brew install git-delta
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
    brew install tmux
    brew install owenthereal/upterm/upterm
    brew install tmuxinator
    brew install ttyrec
    brew install wget
    brew install zsh-autosuggestions
    brew install zsh-syntax-highlighting
    brew install zsh-vi-mode

    # Fonts
    # brew install --cask font-<FONT NAME>-nerd-font
    brew install --cask font-caskaydia-mono-nerd-font
    brew install --cask font-fira-code-nerd-font
    brew install --cask font-gohufont-nerd-font
    brew install --cask font-hack-nerd-font
    brew install --cask font-inconsolata-go-nerd-font
    brew install --cask font-iosevka-term-slab-nerd-font
    brew install --cask font-jetbrains-mono-nerd-font
    brew install --cask font-sauce-code-pro-nerd-font
    brew tap shaunsingh/SFMono-Nerd-Font-Ligaturized
    brew install --cask font-sf-mono-nerd-font-ligaturized
    brew install --cask font-terminess-ttf-nerd-font
    brew install --cask font-zed-mono-nerd-font
    brew install --cask font-meslo-lg-nerd-font

    # Applications
    brew install --cask 1password
    brew install --cask alfred
    brew install --cask blackhole-2ch
    brew install --cask boom
    brew install --cask google-chrome
    brew install --cask karabiner-elements
    brew install --cask obsidian
    brew install --cask rancher
    brew install --cask rectangle
    brew install --cask shifty
    brew install --cask spotify
    brew install --cask topnotch
    brew install --cask wezterm@nightly

    # MacOS specific settings
    ./dotfiles/scripts/macos.sh
fi

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Symlink config files
mkdir -p                                                          "${HOME}/Developer"
ln -svfF "${SCRIPT_DIR}/dotfiles/obsidian.vimrc"                  "${HOME}/Documents/notes/.obsidian.vimrc"
ln -svfF "${SCRIPT_DIR}/dotfiles/zshrc"                           "${HOME}/.zshrc"
ln -svfF "${SCRIPT_DIR}/dotfiles/gitconfig.template"              "${HOME}/.gitconfig.template"
ln -svfF "${SCRIPT_DIR}/dotfiles/psqlrc"                          "${HOME}/.psqlrc"
ln -svfF "${SCRIPT_DIR}/dotfiles/pspgconf"                        "${HOME}/.pspgconf"
ln -svfF "${SCRIPT_DIR}/dotfiles/octaverc"                        "${HOME}/.octaverc"
touch                                                             "${HOME}/.openai_api_key"  # Add openai key to this file.
mkdir -p                                                          "${HOME}/.ssh"
ln -svfF "${SCRIPT_DIR}/dotfiles/ssh_config"                      "${HOME}/.ssh/config"
mkdir -p                                                          "${HOME}/.zsh/funcs"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/aichat_config"             "${HOME}/.zsh/funcs/aichat_config"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/git_config"                "${HOME}/.zsh/funcs/git_config"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/lazygit_config"            "${HOME}/.zsh/funcs/lazygit_config"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/font_picker"               "${HOME}/.zsh/funcs/font_picker"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/dark_mode"                 "${HOME}/.zsh/funcs/dark_mode"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/psqlp"                     "${HOME}/.zsh/funcs/psqlp"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/tmux_session_select"       "${HOME}/.zsh/funcs/tmux_session_select"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/tmuxinator_session_select" "${HOME}/.zsh/funcs/tmuxinator_session_select"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/colorscheme_picker"        "${HOME}/.zsh/funcs/colorscheme_picker"
ln -svfF "${SCRIPT_DIR}/dotfiles/funcs/background_picker"         "${HOME}/.zsh/funcs/background_picker"
mkdir -p                                                          "${XDG_CONFIG_HOME}/wezterm"
ln -svfF "${SCRIPT_DIR}/dotfiles/wezterm/wezterm.lua"             "${XDG_CONFIG_HOME}/wezterm/wezterm.lua"
ln -svfF "${SCRIPT_DIR}/dotfiles/wezterm/helpers.lua"             "${XDG_CONFIG_HOME}/wezterm/helpers.lua"
ln -svfF "${SCRIPT_DIR}/dotfiles/wezterm/backgrounds"             "${XDG_CONFIG_HOME}/wezterm/backgrounds"
mkdir -p                                                          "${XDG_CONFIG_HOME}/lazygit"
ln -svfF "${SCRIPT_DIR}/dotfiles/lazygit.yml.template"            "${XDG_CONFIG_HOME}/lazygit/config.yml.template"
mkdir -p                                                          "${XDG_CONFIG_HOME}/lsd"
ln -svfF "${SCRIPT_DIR}/dotfiles/lsd/config.yaml"                 "${XDG_CONFIG_HOME}/lsd/config.yaml"
ln -svfF "${SCRIPT_DIR}/dotfiles/lsd/colors.yaml"                 "${XDG_CONFIG_HOME}/lsd/colors.yaml"
ln -svfF "${SCRIPT_DIR}/dotfiles/nvim"                            "${XDG_CONFIG_HOME}/nvim"
mkdir -p                                                          "${XDG_CONFIG_HOME}/sqls"
ln -svfF "${SCRIPT_DIR}/dotfiles/sqls_config.yml"                 "${XDG_CONFIG_HOME}/sqls/config.yml"
mkdir -p                                                          "${XDG_CONFIG_HOME}/tmux"
ln -svfF "${SCRIPT_DIR}/dotfiles/tmux.conf"                       "${XDG_CONFIG_HOME}/tmux/tmux.conf"
mkdir -p                                                          "${XDG_CONFIG_HOME}/aichat"
ln -svfF "${SCRIPT_DIR}/dotfiles/aichat_config.yaml.template"     "${XDG_CONFIG_HOME}/aichat/aichat_config.yaml.template"

# OS specific symlinks
if [[ $OSTYPE == darwin* ]]; then
    # NOTE: Needs to be re-copied if changed. Symlinks don't work.
    # https://karabiner-elements.pqrs.org/docs/manual/misc/configuration-file-path/
    cp "${SCRIPT_DIR}/dotfiles/karabiner.json" "${XDG_CONFIG_HOME}/karabiner/karabiner.json"
fi

# Generate SSH keys
while true; do
    read -r "yn?Do you want to generate a new ssh key? (y/n): "

    if [[ $yn == "y" ]]; then
        ./dotfiles/scripts/ssh_keygen.sh
        break
    elif [[ $yn == "n" ]]; then
        break
    else
        echo "Invalid response. Please enter 'y' or 'n'."
    fi
done
