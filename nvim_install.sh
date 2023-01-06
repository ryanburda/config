#!/bin/zsh

SRC_DIR_PATH="$HOME/.nvimDeveloper/src"
NVIM_REPO_PATH="$HOME/.nvim/neovim"
NVIM_PLUGINS_PATH="$HOME/.nvim/plugins"  # empty directory where plugins can be installed and tested locally.
NVIM_INSTALL_DIR_PATH="$HOME/.local/bin/neovim"

mkdir -p $NVIM_PLUGINS_PATH
mkdir -p $NVIM_INSTALL_DIR_PATH

#######################
# Build Prerequisites #
#######################
# Xcode
which -s xcode-select
if [[ $? != 0 ]] ; then
    xcode-select --install
else
    echo "Command Line Tools already installed"
fi

# Homebrew
which -s brew
if [[ $? != 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
fi

brew install --quiet ninja libtool automake cmake pkg-config gettext curl

##############################
# Install NeoVim from source #
##############################
# Clone or pull the neovim repo
git clone git@github.com:neovim/neovim.git $NVIM_REPO_PATH 2> /dev/null || git -C $NVIM_REPO_PATH pull

# Remove any files that neovim may have created previously
sudo rm -rf "$HOME/.local/share/nvim"

# Install neovim
cd $NVIM_REPO_PATH && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make distclean
sudo make install
