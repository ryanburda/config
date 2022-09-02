#!/bin/zsh

# Show task switcher on all monitors.
defaults write com.apple.Dock appswitcher-all-displays -bool true
killall Dock
