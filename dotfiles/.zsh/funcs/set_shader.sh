#!/bin/zsh

SHADER_FOLDER="${XDG_CONFIG_HOME}/.assets/shaders"

set_shader() {
    shaders=$(\ls -lL $SHADER_FOLDER | awk 'NR > 1 {print $9}')
    shaders+=("\nNONE")

    SHADER=$(print $shaders | sort | fzf --cycle --layout reverse)
    if [[ ! -z $SHADER ]]; then
        # Write the value a file.
        envset ghostty_shader "${SHADER_FOLDER}/${SHADER}"
        regenerate_ghostty_config
    fi
}
