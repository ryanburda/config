#!/bin/zsh

# Remove all apps from the dock
defaults write "com.apple.dock" "persistent-apps" -array
killall Dock

# Change key repeat rate and delay until repeat
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

# Turn off CMD-Space shortcut for Spotlight search. (This is used by Alfred)
/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c "Set AppleSymbolicHotKeys:64:enabled false"

cat <<EOF
Manual Changes

Battery -> Options -> Slightly dim the display on battery -> Off
Displays -> Automatically adjust brightness -> Off
Lock Screen -> Start Screen Saver when inactive -> Never
Lock Screen -> Turn display off on battery when inactive -> For 5 minutes
EOF
