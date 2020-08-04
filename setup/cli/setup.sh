#!/usr/bin/env bash

mkdir "${HOME}/Developer"
mkdir "${HOME}/Developer/projects"

xcode-select --install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"


sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
brew install zsh
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
brew install zsh-completions
brew install zsh-syntax-highlighting

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ln -sfv $DIR/bash_profile ~/.bash_profile
ln -sfv $DIR/vimrc ~/.vimrc
ln -sfv $DIR/zshrc ~/.zshrc

brew install git
brew cask install macvim
brew install tig
brew install s3cmd
brew install watch
brew install fswatch
brew install telnet
brew install direnv
brew install kubectl
brew install vault
vault -autocomplete-install

echo "Follow this article to finish setting up iterm https://medium.com/@Clovis_app/configuration-of-a-beautiful-efficient-terminal-and-prompt-on-osx-in-7-minutes-827c29391961"
