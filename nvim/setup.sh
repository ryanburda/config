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

# Install NeoVim from source
sudo rm -rf $NVIM_REPO_PATH
echo 'Cloning neovim'
git clone git@github.com:neovim/neovim.git $NVIM_REPO_PATH

cd $NVIM_REPO_PATH
make CMAKE_BUILD_TYPE=RelWithDebInfo
make CMAKE_INSTALL_PREFIX=$NVIM_INSTALL_DIR_PATH
sudo make install
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
