-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

local function get_var_from_file(file_path)
    local file, err = io.open(file_path, "r")
    if not file then
        print("Could not open file: " .. err)
        return
    end

    local content = file:read("*a")
    -- Remove trailing new lines
    content = content:gsub("%s*$", "")

    file:close()
    return content
end

-- colors
config.color_scheme = "nord"

-- font
config.font = wezterm.font(get_var_from_file("/Users/ryanburda/.config/alacritty/.font"))
config.font_size = tonumber(get_var_from_file("/Users/ryanburda/.config/alacritty/.font_size"))

config.window_decorations = "RESIZE"

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true
config.window_close_confirmation = 'NeverPrompt'

-- and finally, return the configuration to wezterm
return config
