#!/bin/zsh

regenerate_ghostty_config() {
    # TODO: The colorscheme_id should be terminal agnostic.
    #       A ghostty specific mapping of colorscheme_id to colorscheme name should exist in here.

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

    theme_key=$(cat "${XDG_CONFIG_HOME}/wezterm/.colorscheme_key")
    export THEME=${themes[$theme_key]}
    export SHADER=$(cat "${XDG_CONFIG_HOME}/ghostty/.shader")
    export FONT_FAMILY=$(cat "${XDG_CONFIG_HOME}/wezterm/.font")
    export FONT_SIZE=$(cat "${XDG_CONFIG_HOME}/wezterm/.font_size")

    FILE_PATH="${XDG_CONFIG_HOME}/ghostty/config"

    if [ ! -f $FILE_PATH ]; then
        mkdir -p $(dirname "$FILE_PATH")
        touch $FILE_PATH
    fi

    envsubst < "${XDG_CONFIG_HOME}/ghostty/config.template" > $FILE_PATH

}
