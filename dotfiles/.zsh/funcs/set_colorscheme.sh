#!/bin/zsh

set_colorscheme() {
    # NAME
    #   set_colorscheme - synchonizes neovim and terminal colorschemes.
    #
    # DESCRIPTION
    #   Use fzf to select a colorscheme. A colorscheme is applied to both the terminal and neovim.
    #   This script utilizes a hard coded associative list (dictionary) where the keys
    #   are unique theme names that will show up in fzf and the values are strings each
    #   containing:
    #       * the neovim colorscheme
    #       * the neovim background
    #       * the wezterm colorscheme
    #   in that order separated by commas.
    #
    #   The colorscheme changes happen as a result of either writing to files or from regeneration of config files:
    #       - nvim is updated when a change is detected in $XDG_CONFIG_HOME/nvim/.colorscheme
    #       - wezterm is updated by touching $XDG_CONFIG_HOME/wezterm/wezterm.lua
    #       - other scripts exist for handling colorscheme changes to other CLIs such as aichat and lazygit.
    typeset -A themes=(
        ['Dark - Everforest']="everforest,dark,Everforest Dark (Gogh)"
        ['Dark - Darkearth']="darkearth,dark,Gruvbox Material (Gogh)"
        ['Dark - Gruvbox']="gruvbox-material,dark,Gruvbox Material (Gogh)"
        ['Dark - Iceberg']="iceberg,dark,iceberg-dark"
        ['Dark - Nightfox-dusk']="duskfox,dark,duskfox"
        ['Dark - Nightfox-night']="nightfox,dark,nightfox"
        ['Dark - Nightfox-tera']="terafox,dark,terafox"
        ['Dark - Rose-pine']="rose-pine-moon,dark,rose-pine-moon"
        ['Dark - Vague']="vague,dark,Vacuous 2 (terminal.sexy)"
        ['Light - Everforest']="everforest,light,Everforest Light (Gogh)"
        ['Light - Gruvbox']="gruvbox-material,light,GruvboxLight"
        ['Light - Nightfox-dawn']="dawnfox,light,dawnfox"
        ['Light - Nightfox-day']="dayfox,light,dayfox"
        ['Light - Rose-pine']="rose-pine-dawn,light,rose-pine-dawn"
    )

    function set_theme(){
        # Accepts a single parameter that is a valid key into the themes dictionary above.
        theme_key=$1
        values=${themes[$theme_key]}

        if [[ ! -z $values ]]; then
            nvim_colorscheme=$(print $values | awk -F ',' '{print $1}')
            nvim_background=$(print $values | awk -F ',' '{print $2}')
            wezterm_colorscheme=$(print $values | awk -F ',' '{print $3}')

            envset colorscheme_key $theme_key
            envset nvim_colorscheme $nvim_colorscheme
            envset nvim_background $nvim_background
            envset wezterm_colorscheme $wezterm_colorscheme

            # Update all running nvim instances
            local nvim_runtime_dir="${TMPDIR:-/tmp}"
            # Try both macOS pattern (nvim.*/*/nvim.*.0) and Linux pattern (nvim.*/0)
            for socket in "$nvim_runtime_dir"/nvim.*/*/nvim.*.0 "$nvim_runtime_dir"/nvim.*/0; do
                if [[ -S "$socket" ]]; then
                    nvim --server "$socket" --remote-send "<Cmd>luafile ${XDG_CONFIG_HOME}/nvim/lua/colorscheme.lua<CR>"
                fi
            done

            # Regenerate templated configs.
            touch $XDG_CONFIG_HOME/wezterm/wezterm.lua
            regenerate_git_config
            regenerate_lazygit_config
            ~/.zsh/funcs/dark_mode $(if [[ $(envget nvim_background) == 'light' ]]; then echo '-l'; fi)
        fi
    }

    theme_key=$(printf "%s\n" "${(k)themes[@]}" | sort | fzf --layout reverse --cycle --header "$(envget colorscheme_key)")

    if [[ ! -z $theme_key ]]; then
        set_theme $theme_key
    fi
}
