#!/bin/zsh

SCRIPT_DIR=${0:a:h}
NVIM_CONFIG_DIR_PATH_SRC="$SCRIPT_DIR/nvim"
NVIM_CONFIG_DIR_PATH_DST="$HOME/.config"

SRC_DIR_PATH="$HOME/Developer/src"
NVIM_REPO_PATH="$SRC_DIR_PATH/nvim/neovim"
NVIM_PLUGINS_PATH="$SRC_DIR_PATH/nvim/plugins"  # empty directory where plugins can be installed and tested locally.
NVIM_INSTALL_DIR_PATH="$HOME/.local/bin/neovim"

PYENV_PYRIGHT_PATH=$(pyenv root)/plugins/pyenv-pyright

mkdir -p $SRC_DIR_PATH
mkdir -p $NVIM_PLUGINS_PATH
mkdir -p $NVIM_INSTALL_DIR_PATH

# Build prereqs
xcode-select --install
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


# Install NeoVim from source
if [ ! -d $NVIM_REPO_PATH ]; then
    echo 'Cloning neovim'
    git clone git@github.com:neovim/neovim.git $NVIM_REPO_PATH
fi

cd $NVIM_REPO_PATH
echo 'Pulling neovim'
git pull
rm -r build/  # clear the CMake cache
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$NVIM_INSTALL_DIR_PATH"
make install
export PATH="$NVIM_INSTALL_DIR_PATH/bin:$PATH"
cd $SCRIPT_DIR

# Symlink the config directory
mkdir -pv $(dirname $NVIM_CONFIG_DIR_PATH_DST)
ln -svfF $NVIM_CONFIG_DIR_PATH_SRC $NVIM_CONFIG_DIR_PATH_DST


# NOTE: needed for pyright lsp.
# set pyright config file to the current active venv by running the following:
# ```
# pyenv pyright
# ```
if [ ! -d $PYENV_PYRIGHT_PATH ]; then
    git clone https://github.com/alefpereira/pyenv-pyright.git $PYENV_PYRIGHT_PATH
else
    echo 'Pyenv pyright already installed.'
    git -C $PYENV_PYRIGHT_PATH pull
fi


# Automatically install plugings before running nvim for the first time.
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
# This finishes installing treesitter/lsp related things that would otherwise happen the first time nvim is opened.
# NOTE: This will hang! Quit after nothing has happened for a while and find a better way to do this.
nvim --headless
