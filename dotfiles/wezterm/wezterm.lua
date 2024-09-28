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
local function color_scheme_map(color_scheme)
    if color_scheme == "bamboo" then
        return "Bamboo"
    elseif color_scheme == "everforest_dark" then
        return "Everforest Dark (Gogh)"
    elseif color_scheme == "gruvbox_material_medium_dark" then
        return "Gruvbox Material (Gogh)"
    elseif color_scheme == "kanagawa_wave" then
        return "Kanagawa (Gogh)"
    elseif color_scheme == "carbonfox" then
        return "carbonfox"
    elseif color_scheme == "nightfox" then
        return "nightfox"
    elseif color_scheme == "terafox" then
        return "terafox"
    elseif color_scheme == "nord" then
        return "nord"
    elseif color_scheme == "vscode_dark" then
        return "Vs Code Dark+ (Gogh)"
    elseif color_scheme == "neobones" then
        return "neobones_dark"
    elseif color_scheme == "deepwhite" then
        return "Alabaster"
    elseif color_scheme == "everforest_light" then
        return "Everforest Light (Gogh)"
    elseif color_scheme == "gruvbox_material_medium_light" then
        return "GruvboxLight"
    elseif color_scheme == "newpaper" then
        return "PaperColor Light (base16)"
    elseif color_scheme == "dawnfox" then
        return "dawnfox"
    elseif color_scheme == "dayfox" then
        return "dayfox"
    elseif color_scheme == "vscode_light" then
        return "Vs Code Light+ (Gogh)"
    elseif color_scheme == "zenbones_rose" then
        return "zenbones"
    else
        return "Batman"
    end
end

-- NOTE: `os.getenv("XDG_CONFIG_HOME")` returns nil. Using "HOME" as an alternative for now.
config.color_scheme = color_scheme_map(get_var_from_file(os.getenv("HOME") .. "/.config/alacritty/.theme"))

-- font
config.font = wezterm.font(get_var_from_file(os.getenv("HOME") .. "/.config/alacritty/.font"))
config.font_size = tonumber(get_var_from_file(os.getenv("HOME") .. "/.config/alacritty/.font_size"))

local function get_background_config()
    local background_image = get_var_from_file(os.getenv("HOME") .. "/.config/wezterm/.background")

    if background_image == nil then
        return {}
    else
        -- sources are stacked on top of each other in the order they are defined.
        return {
            {
                source = {
                    -- Lay the image down first.
                    File = os.getenv("HOME") .. "/.config/wezterm/backgrounds/" .. background_image
                },
            },
            {
                source = {
                    -- Lay the current color scheme's background color on top of the image and add an opacity.
                    -- This allows the image to show through while retaining the look and feel of the color scheme.
                    Color = wezterm.get_builtin_color_schemes()[config.color_scheme].background
                },
                opacity = 0.94,
                -- height and width needed due to https://github.com/wez/wezterm/issues/2817
                height = '100%',
                width = '100%',
            },
        }
    end
end

-- background
config.background = get_background_config()
config.window_decorations = "RESIZE"
config.text_background_opacity = 0.9

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true
config.window_close_confirmation = 'NeverPrompt'

-- and finally, return the configuration to wezterm
return config
