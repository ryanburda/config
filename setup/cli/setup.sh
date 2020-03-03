#!/usr/bin/env bash

mkdir "${HOME}/Developer"
mkdir "${HOME}/Developer/projects"

xcode-select --install

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
brew install zsh
brew install zsh-completions
brew install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ln -sfv $DIR/bash_profile ~/.bash_profile
ln -sfv $DIR/vimrc ~/.vimrc
ln -sfv $DIR/zshrc ~/.zshrc

brew install git
brew install vim
brew install tig
brew install s3cmd
brew install watch
brew install fswatch
brew install telnet
brew install kubectl

echo "Follow this article to finish setting up iterm https://medium.com/@Clovis_app/configuration-of-a-beautiful-efficient-terminal-and-prompt-on-osx-in-7-minutes-827c29391961"
