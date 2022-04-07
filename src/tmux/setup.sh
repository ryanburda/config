#!/bin/zsh

brew install tmux

CONF_PATH="${0:a:h}/tmux.conf"
ln -svfF $CONF_PATH "${HOME}/.tmux.conf"
