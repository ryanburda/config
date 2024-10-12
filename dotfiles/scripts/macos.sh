#!/bin/zsh

# Remove all apps from the dock
defaults write "com.apple.dock" "persistent-apps" -array
killall Dock

# Change key repeat rate and delay until repeat
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

# Turn off CMD-Space shortcut for Spotlight search. (This is used by Alfred)
/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c "Set AppleSymbolicHotKeys:64:enabled false"
