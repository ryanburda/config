#!/bin/zsh

brew update
brew upgrade
brew cleanup
stow -D dotfiles
stow dotfiles
