#!/bin/zsh

brew install tmux
brew install tmate
brew install tmuxinator

SCRIPT_DIR_PATH=${0:a:h}

ln -svfF "$SCRIPT_DIR_PATH/tmux.conf" "${HOME}/.tmux.conf"
ln -svfF "$SCRIPT_DIR_PATH/tmate.conf" "${HOME}/.tmate.conf"
