#!/bin/zsh

SCRIPT_DIR=${0:a:h}
ln -svfF "${SCRIPT_DIR}/karabiner.json" "${HOME}/.config/karabiner/karabiner.json"
