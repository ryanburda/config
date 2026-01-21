#!/bin/zsh

DEFAULT_FONT_FAMILY="JetBrainsMono Nerd Font Mono"
DEFAULT_FONT_SIZE="12"

set_font() {
    # NAME
    #   set_font - changes terminal font.
    #
    # DESCRIPTION
    #   Use fzf to select a font.
    fonts=(
        "CaskaydiaMono Nerd Font Mono,13"
        "DepartureMono Nerd Font Mono,13"
        "FiraMono Nerd Font Mono,12"
        "GohuFont 14 Nerd Font Mono,12"
        "Hack Nerd Font Mono,12"
        "InconsolataGo Nerd Font Mono,14"
        "JetBrainsMono Nerd Font Mono,12"
        "MartianMono Nerd Font Mono,11"
        "RecMonoCasual Nerd Font Mono,12"
        "Terminess Nerd Font Mono,13"
    )

    current_font_family=$(envget font_family $DEFAULT_FONT_FAMILY)
    current_font_size=$(envget font_size $DEFAULT_FONT_SIZE)

    selection=$(printf "%s\n" "${fonts[@]}" | sort | fzf --layout reverse --cycle --header "${current_font_family},${current_font_size}")
    if [[ -n "${selection}" ]]; then
        font_family=$(print $selection | awk -F ',' '{print $1}')
        font_size=$(print $selection | awk -F ',' '{print $2}')

        envset font_family $font_family
        envset font_size $font_size

        # reload terminal configs
        touch $XDG_CONFIG_HOME/wezterm/wezterm.lua
    fi
}
