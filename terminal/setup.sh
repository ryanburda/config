#!/bin/zsh

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
    brew install --cask kitty
    brew install --cask google-chrome
    brew install --cask firefox
    brew install --cask karabiner-elements
    brew install --cask alfred
    brew install --cask rectangle
    brew install --cask spotify
    brew install --cask utm
fi

# Install common dependencies
xcode-select --install

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
brew install rust
brew install php
brew install composer
brew install pyenv
brew install pyenv-virtualenv
brew install lazygit
brew install fd
brew install tig
brew install htop
brew install node
brew install lua
brew install ripgrep
brew install jq
brew install ttyrec
brew install rlwrap
brew install lf
brew install howdoi

brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font 
brew install --cask font-jetbrains-mono
brew install --cask font-sf-mono


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
ln -svfF "${SCRIPT_DIR}/dotfiles/kitty.conf" "${HOME}/.config/kitty/kitty.conf"
ln -svfF "${SCRIPT_DIR}/dotfiles/karabiner.json" "${HOME}/.config/karabiner/karabiner.json"

# Set the default git pull strategy
git config --global pull.ff only


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


# TODO: stop using oh my zsh
# Install oh my zsh
if ! [ -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi


# zsh plugins
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# Pure theme
#     - This theme separate from oh-my-zsh. Keeping oh-my-zsh around since it provides more than just pretty colors.
#     - This theme can't currently be installed using brew due to an issue with M1 macs where themes are not added to the `fpath`. https://github.com/sindresorhus/pure/issues/584
#           * Performing manual install to get around this so it works on both M1 and Intel macs. https://github.com/sindresorhus/pure#manually
#
# NOTE: The following must be added to .zshrc
# ```
# fpath+="$HOME/.zsh/pure"
# ```
mkdir -p "$HOME/.zsh"
PURE_PATH="$HOME/.zsh/pure"

if ! [ -d $PURE_PATH ]; then
    git clone https://github.com/sindresorhus/pure.git $PURE_PATH
fi
