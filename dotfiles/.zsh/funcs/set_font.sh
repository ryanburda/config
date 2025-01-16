#!/bin/zsh

set_font() {
    # NAME
    #   set_font - changes terminal font.
    #
    # DESCRIPTION
    #   Use fzf to select a font.
    fonts=(
        "CaskaydiaMono Nerd Font Mono,14"
        "FiraCode Nerd Font Mono,12"
        "GohuFont 14 Nerd Font Mono,13"
        "Hack Nerd Font Mono,12"
        "JetBrainsMono Nerd Font Mono,12"
        "Liga SFMono Nerd Font,12"
        "MesloLGM Nerd Font,12"
        "SauceCodePro Nerd Font Mono,12"
        "Terminess Nerd Font Mono,14"
        "IosevkaTermSlab Nerd Font Mono,13"
        "InconsolataGo Nerd Font Mono,14"
        "ZedMono Nerd Font Mono,13"
    )

    current_font=$(<$XDG_CONFIG_HOME/wezterm/.font)
    current_font_size=$(<$XDG_CONFIG_HOME/wezterm/.font_size)

    selection=$(printf "%s\n" "${fonts[@]}" | sort | fzf --cycle)
    if [[ -n "${selection}" ]]; then
        echo $(print $selection| awk -F ',' '{print $1}') > $XDG_CONFIG_HOME/wezterm/.font
        echo $(print $selection| awk -F ',' '{print $2}') > $XDG_CONFIG_HOME/wezterm/.font_size

        # force reload of wezterm config
        touch $XDG_CONFIG_HOME/wezterm/wezterm.lua
    fi
}
