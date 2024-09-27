-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- colors
config.color_scheme = "Catppuccin Macchiato"

-- font
config.font = wezterm.font("JetBrains Mono NL")
config.font_size = 16

config.window_decorations = "RESIZE"

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

-- and finally, return the configuration to wezterm
return config
