#!/bin/zsh
SCRIPT_DIR=${0:a:h}
ln -svfF "$SCRIPT_DIR/session.yml" "$HOME/.config/tmuxinator/config.yml"
