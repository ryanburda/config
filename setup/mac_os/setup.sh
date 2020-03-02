#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ln -sfv $DIR/com.apple.symbolichotkeys.plist ~/Library/Preferences/com.apple.symbolichotkeys.plist

defaults write -g InitialKeyRepeat -int 5 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
