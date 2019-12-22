# Assumes all of the config files are in the same directory as this script.
DIRECTORY=$(pwd)
ln -sf $DIRECTORY/bashrc ~/.bashrc
ln -sf $DIRECTORY/bash_profile ~/.bash_profile
ln -sf $DIRECTORY/zshrc ~/.zshrc
ln -sf $DIRECTORY/zsh ~/.zsh
ln -sf $DIRECTORY/vimrc ~/.vimrc
ln -sf $DIRECTORY/direnvrc ~/.direnvrc
ln -sf $DIRECTORY/karabiner.json ~/.config/karabiner/karabiner.json
