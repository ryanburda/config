#!/bin/zsh

set_background() {
    # NAME
    #   set_background
    #
    # SYNOPSIS
    #   Terminal background image picker.
    #
    # DESCRIPTION
    #   Use fzf to select a background image.
    #   The selected image is written to a file.
    #   The wezterm.lua file is then reloaded to
    #   trigger the code that performs the image change.
    #   The neovim colorsheme file is touched in order
    #   to force an update of the neovim colorscheme
    #   to either apply or remove transparency.

    current_background=$(<$XDG_CONFIG_HOME/wezterm/.background)
    backgrounds=$(\ls ${XDG_CONFIG_HOME}/wezterm/backgrounds)
    backgrounds+=("\nTRANSPARENT")
    backgrounds+=("\nNONE")
    selection=$(print $backgrounds | sort | fzf --cycle)

    if [[ -n "${selection}" ]]; then
        BACKGROUND_FILE_PATH=$XDG_CONFIG_HOME/wezterm/.background

        if [[ ! -z $selection ]]; then
            # Persist the selection to a file.
            echo $selection > $BACKGROUND_FILE_PATH
            # Touch the wezterm config to reload wezterm
            touch $XDG_CONFIG_HOME/wezterm/wezterm.lua
            # Touch the .colorscheme file. This file is being watched for changes.
            # When a change is detected the neovim colorscheme is changed to the contents of the file.
            # Changing the colorscheme then fires the ColorScheme autocmd in `transparency.lua`.
            #
            # This will make certain highlight groups transparent allowing the background image to show up.
            touch $XDG_CONFIG_HOME/nvim/.colorscheme
        fi
    fi
}
