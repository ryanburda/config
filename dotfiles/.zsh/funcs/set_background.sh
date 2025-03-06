#!/bin/zsh

set_background() {
    # NAME
    #   set_background
    #
    # DESCRIPTION
    #   Terminal background image picker.
    current_background=$(envget wezterm_background)
    backgrounds=$(\ls "${XDG_CONFIG_HOME}/.assets/backgrounds")
    backgrounds+=("\nTRANSPARENT")
    backgrounds+=("\nNONE")

    selection=$(print $backgrounds | sort | fzf --layout reverse --cycle --header "${current_background}")

    if [[ -n "${selection}" ]]; then
        if [[ ! -z $selection ]]; then
            # Persist the selection to a file.
            envset wezterm_background $selection
            # Touch the wezterm config to reload wezterm
            touch $XDG_CONFIG_HOME/wezterm/wezterm.lua
            # Touch the nvim_colorscheme environment variable to apply/remove transparency in neovim.
            envtouch nvim_colorscheme
        fi
    fi
}
