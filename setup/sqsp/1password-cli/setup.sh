#!/usr/bin/env bash
brew cask install 1password-cli

eval $(op signin https://squarespace.1Password.com)
