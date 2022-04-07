#!/bin/zsh

# Dependency
brew install rlwrap

# Install cht.sh
CHTSH_PATH="$HOME/bin/cht.sh"

if ! [ -f $CHTSH_PATH ]; then
    curl -fLo $CHTSH_PATH --create-dirs https://cht.sh/:cht.sh
    chmod +x $CHTSH_PATH
else
    echo "cht.sh is already installed"
fi

# Autocomplete
AUTOCOMPLETE_PATH="$HOME/.zsh/compdef/_cht"

if ! [ -f $AUTOCOMPLETE_PATH ]; then
    curl -fLo $AUTOCOMPLETE_PATH --create-dirs https://cheat.sh/:zsh
    chmod +x $AUTOCOMPLETE_PATH
else
    echo "cht.sh autocomplete already installed"
fi
