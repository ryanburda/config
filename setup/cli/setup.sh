#!/usr/bin/env bash

xcode-select --install

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew install tig
brew install zsh

echo "Follow this article to finish setting up iterm https://medium.com/@Clovis_app/configuration-of-a-beautiful-efficient-terminal-and-prompt-on-osx-in-7-minutes-827c29391961"
