#!/usr/bin/env bash

brew cask install rectangle

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ln -sfv $DIR/Rectangle.plist ~/Library/Preferences/com.knollsoft.Rectangle.plist
