#!/usr/bin/env bash

brew cask install karabiner-elements
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ln -sfv $DIR/karabiner.json ~/.config/karabiner/karabiner.json
