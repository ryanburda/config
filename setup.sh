#!/bin/zsh

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
brew install cloud-sql-proxy
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
brew install kubetui
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
brew install owenthereal/upterm/upterm  # See https://github.com/owenthereal/upterm/issues/135 if you are having issues with `upterm host`
brew install php
brew install pkg-config
brew install pspg
brew install pyenv
brew install pyenv-virtualenv
brew install ripgrep
brew install rlwrap
brew install sk
brew install stow
brew install tmux
brew install tmuxinator
brew install ttyrec
brew install wget
# Fonts
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

# Symlink config files
stow dotfiles

# tmux-plugin-manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Add openai key to this file.
# TODO: automate adding this.
touch "${HOME}/.openai_api_key"

# MacOS specific settings
./scripts/macos.sh

# Generate SSH keys
while true; do
    read -r "yn?Do you want to generate a new ssh key? (y/n): "

    if [[ $yn == "y" ]]; then
        ./scripts/ssh_keygen.sh
        break
    elif [[ $yn == "n" ]]; then
        break
    else
        echo "Invalid response. Please enter 'y' or 'n'."
    fi
done
