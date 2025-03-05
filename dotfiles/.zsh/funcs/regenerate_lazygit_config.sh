#!/bin/zsh

regenerate_lazygit_config() {
    export LIGHT_OR_DARK=$(envget nvim_background)

    FILE_PATH="${XDG_CONFIG_HOME}/lazygit/config.yml"

    if [ ! -f $FILE_PATH ]; then
        mkdir -p $(dirname "$FILE_PATH")
        touch $FILE_PATH
    fi

    envsubst < "${XDG_CONFIG_HOME}/lazygit/config.yml.template" > $FILE_PATH
}
