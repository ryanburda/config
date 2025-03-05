#!/bin/zsh

regenerate_git_config() {
    export LIGHT_OR_DARK=$(envget nvim_background)

    FILE_PATH="${HOME}/.gitconfig"

    if [ ! -f $FILE_PATH ]; then
        mkdir -p $(dirname "$FILE_PATH")
        touch $FILE_PATH
    fi

    envsubst < "${HOME}/.gitconfig.template" > $FILE_PATH
}
