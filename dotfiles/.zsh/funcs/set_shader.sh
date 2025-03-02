#!/bin/zsh

SHADER_FILE_PATH="${XDG_CONFIG_HOME}/ghostty/.shader"
SHADER_FOLDER="${XDG_CONFIG_HOME}/ghostty/ghostty-shaders"

set_shader() {
    shaders=$(\ls -l $SHADER_FOLDER | awk 'NR > 1 {print $9}')
    shaders+=("\nNONE")

    SHADER=$(print $shaders | sort | fzf --cycle --layout reverse)
    if [[ ! -z $SHADER ]]; then
        # Write the value a file.
        echo "ghostty-shaders/${SHADER}" > $SHADER_FILE_PATH
        regenerate_ghostty_config
    fi
}
