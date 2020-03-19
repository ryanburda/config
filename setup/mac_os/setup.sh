#!/usr/bin/env bash

# defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
# defaults write -g KeyRepeat -int 2 # normal minimum is 2 (30 ms)
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE
