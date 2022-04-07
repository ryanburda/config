#!/bin/zsh

SCRIPT_DIR=${0:a:h}
NVIM_CONFIG_DIR="${SCRIPT_DIR}/nvim"
NVIM_CONFIG_DIR_LNK="${HOME}/.config"

# Install NeoVim and symlink the config directory
brew install neovim
mkdir -pv $NVIM_CONFIG_DIR_LNK
ln -svfF $NVIM_CONFIG_DIR $NVIM_CONFIG_DIR_LNK

# Install Vim-Plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install Node for coc.nvim
brew install node
