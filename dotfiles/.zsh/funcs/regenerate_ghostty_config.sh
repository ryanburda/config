#!/bin/zsh

regenerate_ghostty_config() {

    typeset -A themes=(
        ['Dark - Bamboo']="Batman"
        ['Dark - Catppuccin']="catppuccin-mocha"
        ['Dark - Everforest']="Everforest Dark - Hard"
        ['Dark - Evergarden']="Batman"
        ['Dark - Gruvbox']="GruvboxDark"
        ['Dark - Melange']="Batman"
        ['Dark - Melange2']="Batman"
        ['Dark - Nightfox-night']="Batman"
        ['Dark - Nightfox-tera']="Batman"
        ['Dark - Nord']="nord"
        ['Dark - Nordic']="Batman"
        ['Dark - Rose-pine']="rose-pine-moon"
        ['Light - Catppuccin']="catppuccin-latte"
        ['Light - Deep-White']="Batman"
        ['Light - Everforest']="Everforest Dark - Hard"
        ['Light - Gruvbox']="GruvboxLight"
        ['Light - Melange']="Batman"
        ['Light - Nightfox-dawn']="Batman"
        ['Light - Nightfox-day']="Batman"
        ['Light - Rose-pine']="rose-pine-dawn"
    )

    theme_key=$(envget colorscheme_key "Dark - Rose-pine")
    export THEME=${themes[$theme_key]}

    export FONT_FAMILY=$(envget font_family)
    export FONT_SIZE=$(envget font_size)

    export SHADER=$(envget ghostty_shader "NONE")

    FILE_PATH="${XDG_CONFIG_HOME}/ghostty/config"

    if [ ! -f $FILE_PATH ]; then
        mkdir -p $(dirname "$FILE_PATH")
        touch $FILE_PATH
    fi

    envsubst < "${XDG_CONFIG_HOME}/ghostty/config.template" > $FILE_PATH
}
