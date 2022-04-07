#!/bin/zsh

# Create bin directory
# All custom scripts should be put here
mkdir -p "$HOME/bin"

# Create the compdef directory
# All custom compdef files should be put here
mkdir -p "$HOME/.zsh/compdef"

# Install oh my zsh
if ! [ -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Symlink zshrc
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
