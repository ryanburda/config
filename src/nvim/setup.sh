#!/bin/zsh

SCRIPT_DIR=${0:a:h}
INIT_VIM_PATH="${SCRIPT_DIR}/init.vim"
INIT_VIM_LNK_PATH="${HOME}/.config/nvim/init.vim"

# Install NeoVim and symlink the config directory
brew install neovim
mkdir -pv $(dirname "$INIT_VIM_LNK_PATH")
ln -svfF $INIT_VIM_PATH $INIT_VIM_LNK_PATH

# Install Vim-Plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Needed for coc.nvim
brew install node
brew install yarn
