#!/bin/zsh

# Create bin directory
# All custom scripts should be put here
mkdir -p "$HOME/.local/bin"

# Create the compdef directory
# All custom compdef files should be put here
mkdir -p "$HOME/.zsh/compdef"

# Create commonly used directories
mkdir -p $HOME/Developer
mkdir -p $HOME/Developer/scratch/notes
mkdir -p $HOME/Developer/scratch/src

# Set the default git pull strategy
git config --global pull.ff only

# Install oh my zsh
if ! [ -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
SCRIPT_DIR=${0:a:h}
ln -svfF "$SCRIPT_DIR/zshrc" "$HOME/.zshrc"

# Plugins
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Pure theme
#     - This theme separate from oh-my-zsh. Keeping oh-my-zsh around since it provides more than just pretty colors.
#     - This theme can't currently be installed using brew due to an issue with M1 macs where themes are not added to the `fpath`. https://github.com/sindresorhus/pure/issues/584
#           * Performing manual install to get around this so it works on both M1 and Intel macs. https://github.com/sindresorhus/pure#manually
#
# NOTE: The following must be added to .zshrc
# ```
# fpath+="$HOME/.zsh/pure"
# ```
mkdir -p "$HOME/.zsh"
PURE_PATH="$HOME/.zsh/pure"

if ! [ -d $PURE_PATH ]; then
    git clone https://github.com/sindresorhus/pure.git $PURE_PATH
fi


# Iterm colors
# curl -fLo "$HOME/Downloads/Snazzy.itermcolors" https://raw.githubusercontent.com/sindresorhus/iterm2-snazzy/main/Snazzy.itermcolors
# open "$HOME/Downloads/Snazzy.itermcolors"
curl -fLo "$HOME/Downloads/Everforest.itermcolors" https://raw.githubusercontent.com/icewind/everforest.iterm2/main/Everforest_hard_dark.itermcolors
open "$HOME/Downloads/Everforest.itermcolors"
curl -fLo "$HOME/Downloads/GruvboxDark.itermcolors" https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Gruvbox%20Dark.itermcolors
open "$HOME/Downloads/GruvboxDark.itermcolors"
curl -fLo "$HOME/Downloads/GruvboxLight.itermcolors" https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Gruvbox%20Light.itermcolors
open "$HOME/Downloads/GruvboxLight.itermcolors"


# Install Homebrew
which -s brew
if [[ $? != 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
fi


# Install common dependencies
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font 
brew install tig
brew install htop
brew install node
brew install lua
brew install ripgrep
brew install jq
brew install pyenv
brew install pyenv-virtualenv
brew install ttyrec
brew install rlwrap
brew install --cask google-cloud-sdk
brew install lf


# cloud-sql-proxy
CPU=$(sysctl -n machdep.cpu.brand_string)
CLOUD_SQL_PROXY_PATH=$HOME/.local/bin/cloud_sql_proxy 

if [[ $CPU =~ ^Apple ]]; then
    curl -o $CLOUD_SQL_PROXY_PATH https://dl.google.com/cloudsql/cloud_sql_proxy.darwin.arm64
    chmod +x $CLOUD_SQL_PROXY_PATH
elif [[ $CPU =~ ^Intel ]]; then
    curl -o $CLOUD_SQL_PROXY_PATH https://dl.google.com/cloudsql/cloud_sql_proxy.darwin.amd64
    chmod +x $CLOUD_SQL_PROXY_PATH
else
    echo "WARNING: could not determine which cloud-sql-proxy version to install."
fi


# Cheet sheet
CHTSH_PATH="$HOME/.local/bin/cht.sh"

if ! [ -f $CHTSH_PATH ]; then
    curl -fLo $CHTSH_PATH --create-dirs https://cht.sh/:cht.sh
    chmod +x $CHTSH_PATH
else
    echo "cht.sh is already installed"
fi

AUTOCOMPLETE_PATH="$HOME/.zsh/compdef/_cht"

if ! [ -f $AUTOCOMPLETE_PATH ]; then
    curl -fLo $AUTOCOMPLETE_PATH --create-dirs https://cheat.sh/:zsh
    chmod +x $AUTOCOMPLETE_PATH
else
    echo "cht.sh autocomplete already installed"
fi


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
