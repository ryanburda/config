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
        ['Dark - Bamboo']="bamboo,dark,Bamboo"
        ['Dark - Catppuccin']="catppuccin-mocha,dark,Catppuccin Mocha"
        ['Dark - Everforest']="everforest,dark,Everforest Dark (Gogh)"
        ['Dark - Evergarden']="evergarden,dark,Andromeda"
        ['Dark - Gruvbox']="gruvbox-material,dark,Gruvbox Material (Gogh)"
        ['Dark - Kanagawa-paper']="kanagawa-paper,dark,Kanagawa (Gogh)"
        ['Dark - Kanagawa-wave']="kanagawa-wave,dark,Kanagawa (Gogh)"
        ['Dark - Lackluster']="lackluster,dark,carbonfox"
        ['Dark - Monokai']="monokai-nightasty,dark,Monokai Pro (Gogh)"
        ['Dark - Nightfox-carbon']="carbonfox,dark,carbonfox"
        ['Dark - Nightfox-night']="nightfox,dark,nightfox"
        ['Dark - Nightfox-tera']="terafox,dark,terafox"
        ['Dark - Nord']="nordfox,dark,nord"
        ['Dark - Nordic']="nordic,dark,Andromeda"
        ['Dark - Sonokai']="sonokai,dark,Monokai Pro (Gogh)"
        ['Dark - VSCode']="vscode,dark,Vs Code Dark+ (Gogh)"
        ['Dark - ZenBones-forest']="forestbones,dark,Everforest Dark (Gogh)"
        ['Dark - ZenBones-neo']="neobones,dark,neobones_dark"
        ['Light - Catppuccin']="catppuccin-latte,light,catppuccin-latte"
        ['Light - Deep-White']="deepwhite,light,Alabaster"
        ['Light - Everforest']="everforest,light,Everforest Light (Gogh)"
        ['Light - Gruvbox']="gruvbox-material,light,GruvboxLight"
        ['Light - Monokai']="monokai-nightasty,light,Monokai (light) (terminal.sexy)"
        ['Light - Newpaper']="newpaper,light,PaperColor Light (base16)"
        ['Light - Nightfox-dawn']="dawnfox,light,dawnfox"
        ['Light - Nightfox-day']="dayfox,light,dayfox"
        ['Light - VSCode']="vscode,light,Vs Code Light+ (Gogh)"
        ['Light - ZenBones-rose']="rosebones,light,zenbones"
    )

    function set_theme(){
        # Accepts a single parameter that is a valid key into the themes dictionary above.
        theme_key=$1
        values=${themes[$theme_key]}

        if [[ ! -z $values ]]; then
            nvim_colorscheme=$(print $values | awk -F, '{print $1}')
            nvim_background=$(print $values | awk -F, '{print $2}')
            wezterm_colorscheme=$(print $values | awk -F, '{print $3}')

            # Write the values to files.
            echo "$nvim_colorscheme" > $XDG_CONFIG_HOME/nvim/.colorscheme
            echo "$nvim_background" > $XDG_CONFIG_HOME/nvim/.background
            echo "$wezterm_colorscheme" > $XDG_CONFIG_HOME/wezterm/.colorscheme

            # This is used below to show a check mark next to the current theme when selecting via fzf
            echo "$theme_key" > $XDG_CONFIG_HOME/wezterm/.colorscheme_key

            # Regenerate templated configs.
            touch $XDG_CONFIG_HOME/wezterm/wezterm.lua
            regenerate_aichat_config
            regenerate_git_config
            regenerate_lazygit_config
            ~/.zsh/funcs/dark_mode $(if [[ $b == 'light' ]]; then echo '-l'; fi)
        fi
    }

    current_theme_key=$(<$XDG_CONFIG_HOME/wezterm/.colorscheme_key)
    theme_key=$(printf "%s\n" "${(k)themes[@]}" | sort | fzf --cycle)

    if [[ ! -z $theme_key ]]; then
        set_theme $theme_key
    fi
}
