#!/bin/zsh

# Install Homebrew
which -s brew
if [[ $? != 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
fi

brew install 1password-cli
brew install aichat
brew install automake #n
brew install bat
brew install bottom
brew install cmake #n
brew install cloud-sql-proxy
brew install composer #n
brew install coreutils
brew install curl
brew install deno #n
brew install fd
brew install fzf
$(brew --prefix)/opt/fzf/install #n
brew install fzy
brew install gettext #n
brew install gh
brew install git-delta
brew install go
brew install jq
brew install k9s
brew install kubectl
brew install kubectx
brew install kubetui
brew install lazydocker
brew install lazygit
brew install libpq #n
brew link --force libpq #n
brew install libtool #n
brew install lsd
brew install lua
brew install neovim
brew install ninja #n
brew install node #n
brew install npm
brew install octave
brew install owenthereal/upterm/upterm  # See https://github.com/owenthereal/upterm/issues/135 if you are having issues with `upterm host`
brew install php #n
brew install pkg-config #n
brew install pspg
brew install pyenv
brew install pyenv-virtualenv
brew install poetry
brew install ripgrep
brew install rlwrap
brew install stow
brew intsall tldr
brew install tmux
brew install tmuxinator
brew install wget
# Fonts
brew install --cask font-caskaydia-mono-nerd-font
brew install --cask font-departure-mono-nerd-font
brew install --cask font-fira-mono-nerd-font
brew install --cask font-gohufont-nerd-font
brew install --cask font-hack-nerd-font
brew install --cask font-inconsolata-go-nerd-font
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-martian-mono-nerd-font
brew install --cask font-recursive-mono-nerd-font
brew install --cask font-terminess-ttf-nerd-font
# Applications
brew install --cask 1password
brew install --cask alfred
brew install --cask blackhole-2ch
brew install --cask ghostty
brew install --cask google-chrome
brew install --cask karabiner-elements
brew install --cask obsidian
brew install --cask rancher
brew install --cask rectangle
brew install --cask shifty
brew install --cask spotify
brew install --cask wezterm@nightly

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# terminal gif recorder
cargo install --locked --git https://github.com/asciinema/asciinema
cargo install --git https://github.com/asciinema/agg
go install github.com/cirocosta/asciinema-edit@latest

# Symlink config files
stow dotfiles

# Source zshrc to get access to environment variables.
source ~/.zshrc

# Create environment variables directory.
mkdir -p $ENV_DIR

# If config repo is in normal location then this is `SCRIPT_DIR=$HOME/Developer/config`
# The following can be used when testing manually:  `SCRIPT_DIR=$(pwd)`
SCRIPT_DIR=${0:a:h}
# karabiner.json needs to be copied.
# https://karabiner-elements.pqrs.org/docs/manual/misc/configuration-file-path/
mkdir -p "${HOME}/.config/karabiner"
cp "${SCRIPT_DIR}/dotfiles/.config/karabiner.json" "${HOME}/.config/karabiner/karabiner.json"

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
