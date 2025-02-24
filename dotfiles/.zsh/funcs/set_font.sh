#!/bin/zsh

FONT_FILE_PATH="${XDG_CONFIG_HOME}/wezterm/.font"
FONT_SIZE_FILE_PATH="${XDG_CONFIG_HOME}/wezterm/.font_size"

set_font() {
    # NAME
    #   set_font - changes terminal font.
    #
    # DESCRIPTION
    #   Use fzf to select a font.
    fonts=(
        "CaskaydiaMono Nerd Font Mono,13"
        "FiraCode Nerd Font Mono,12"
        "GohuFont 14 Nerd Font Mono,13"
        "Hack Nerd Font Mono,12"
        "JetBrainsMono Nerd Font Mono,12"
        "Liga SFMono Nerd Font,12"
        "MesloLGM Nerd Font,12"
        "SauceCodePro Nerd Font Mono,12"
        "Terminess Nerd Font Mono,14"
        "InconsolataGo Nerd Font Mono,14"
    )

    current_font=$(<$FONT_FILE_PATH)
    current_font_size=$(<$FONT_SIZE_FILE_PATH)

    selection=$(printf "%s\n" "${fonts[@]}" | sort | fzf --layout reverse --cycle --header "${current_font},${current_font_size}")
    if [[ -n "${selection}" ]]; then
        echo $(print $selection| awk -F ',' '{print $1}') > $FONT_FILE_PATH
        echo $(print $selection| awk -F ',' '{print $2}') > $FONT_SIZE_FILE_PATH

        # force reload of wezterm config
        touch $XDG_CONFIG_HOME/wezterm/wezterm.lua
    fi
}
