#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ln -sfv $DIR/bash_profile ~/.bash_profile
ln -sfv $DIR/vimrc ~/.vimrc
ln -sfv $DIR/zshrc ~/.zshrc
