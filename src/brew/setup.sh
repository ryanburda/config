#!/bin/zsh

# Install Homebrew
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
fi

# Other useful installs
brew tap homebrew/cask-fonts
brew install font-hack
brew install tig

# Applications
read -qs "tf?Install applications? ('y' to install, any other key to skip)"
if [[ "$tf" =~ ^[Yy]$ ]]
then
    brew install --cask iterm2
    brew install --cask google-chrome
    brew install --cask firefox
    brew install --cask karabiner-elements
    brew install --cask alfred
    brew install --cask rectangle
    brew install --cask spotify
fi
