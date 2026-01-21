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

            # Update all running nvim instances (removes transparency)
            local nvim_runtime_dir="${TMPDIR:-/tmp}"
            # Try both macOS pattern (nvim.*/*/nvim.*.0) and Linux pattern (nvim.*/0)
            for socket in "$nvim_runtime_dir"/nvim.*/*/nvim.*.0 "$nvim_runtime_dir"/nvim.*/0; do
                if [[ -S "$socket" ]]; then
                    # redirect stderr to /dev/null since stale socket files can remain even after Neovim instances have closed.
                    nvim --server "$socket" --remote-send "<Cmd>luafile ${XDG_CONFIG_HOME}/nvim/lua/colorscheme.lua<CR>" 2>/dev/null
                fi
            done
        fi
    fi
}
