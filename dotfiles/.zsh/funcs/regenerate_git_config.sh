#!/bin/zsh

regenerate_git_config() {
    export LIGHT_OR_DARK=$(cat $XDG_CONFIG_HOME/nvim/.background)

    FILE_PATH="${HOME}/.gitconfig"

    if [ ! -f $FILE_PATH ]; then
        mkdir -p $(dirname "$FILE_PATH")
        touch $FILE_PATH
    fi

    envsubst < "${HOME}/.gitconfig.template" > $FILE_PATH
}
