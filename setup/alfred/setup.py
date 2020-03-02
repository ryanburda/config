#!/usr/bin/env bash

brew cask install alfred

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ln -sfv $DIR/com.runningwithcrayons.Alfred-Preferences.plist ~/Library/Preferences/com.runningwithcrayons.Alfred-Preferences.plist
