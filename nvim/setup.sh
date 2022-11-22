#!/bin/zsh

SCRIPT_DIR=${0:a:h}
NVIM_CONFIG_DIR_PATH_SRC="$SCRIPT_DIR/nvim"
NVIM_CONFIG_DIR_PATH_DST="$HOME/.config"

SRC_DIR_PATH="$HOME/Developer/src"
NVIM_REPO_PATH="$SRC_DIR_PATH/nvim/neovim"
NVIM_PLUGINS_PATH="$SRC_DIR_PATH/nvim/plugins"  # empty directory where plugins can be installed and tested locally.
NVIM_INSTALL_DIR_PATH="$HOME/.local/bin/neovim"

mkdir -p $SRC_DIR_PATH
mkdir -p $NVIM_PLUGINS_PATH
mkdir -p $NVIM_INSTALL_DIR_PATH

#######################
# Build Prerequisites #
#######################
# Xcode
xcode-select --install

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

# Symlink your neovim config 
mkdir -pv $(dirname $NVIM_CONFIG_DIR_PATH_DST)
ln -svfF $NVIM_CONFIG_DIR_PATH_SRC $NVIM_CONFIG_DIR_PATH_DST

# Remove any files that neovim may have created previously
sudo rm -rf "$HOME/.local/share/nvim"

# Install neovim
cd $NVIM_REPO_PATH && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

################
# Post Install #
################
# Install plugins
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
