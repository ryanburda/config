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
-- TODO: Move this logic to the colorscheme_picker
local function color_scheme_map(color_scheme)
    if color_scheme == "Dark - Bamboo" then
        return "Bamboo"
    elseif color_scheme == "Dark - Everforest" then
        return "Everforest Dark (Gogh)"
    elseif color_scheme == "Dark - Adwaita" then
        return "Modus Vivendi (Gogh)"
    elseif color_scheme == "Dark - Gruvbox" then
        return "Gruvbox Material (Gogh)"
    elseif color_scheme == "Dark - Kanagawa-paper" then
        return "Kanagawa (Gogh)"
    elseif color_scheme == "Dark - Kanagawa-wave" then
        return "Kanagawa (Gogh)"
    elseif color_scheme == "Dark - Nightfox-carbon" then
        return "Modus Vivendi (Gogh)"
    elseif color_scheme == "Dark - Nightfox-night" then
        return "nightfox"
    elseif color_scheme == "Dark - Nightfox-tera" then
        return "terafox"
    elseif color_scheme == "Dark - Nord" then
        return "nord"
    elseif color_scheme == "Dark - VSCode" then
        return "Vs Code Dark+ (Gogh)"
    elseif color_scheme == "Dark - ZenBones-forest" then
        return "Everforest Dark (Gogh)"
    elseif color_scheme == "Dark - ZenBones-neo" then
        return "neobones_dark"
    elseif color_scheme == "Light - Deep-White" then
        return "Alabaster"
    elseif color_scheme == "Light - Everforest" then
        return "Everforest Light (Gogh)"
    elseif color_scheme == "Light - Gruvbox" then
        return "GruvboxLight"
    elseif color_scheme == "Light - Newpaper" then
        return "PaperColor Light (base16)"
    elseif color_scheme == "Light - Nightfox-dawn" then
        return "dawnfox"
    elseif color_scheme == "Light - Nightfox-day" then
        return "dayfox"
    elseif color_scheme == "Light - VSCode" then
        return "Vs Code Light+ (Gogh)"
    elseif color_scheme == "Light - ZenBones-rose" then
        return "zenbones"
    elseif color_scheme == "Light - Adwaita" then
        return "Modus Operandi (Gogh)"
    else
        return "Batman"
    end
end

-- NOTE: `os.getenv("XDG_CONFIG_HOME")` returns nil. Using "HOME" as an alternative for now.
config.color_scheme = color_scheme_map(get_var_from_file(os.getenv("HOME") .. "/.config/wezterm/.colorscheme_key"))

-- font
config.font = wezterm.font(get_var_from_file(os.getenv("HOME") .. "/.config/wezterm/.font"))
config.font_size = tonumber(get_var_from_file(os.getenv("HOME") .. "/.config/wezterm/.font_size"))

local function get_background_config()
    local background_image = get_var_from_file(os.getenv("HOME") .. "/.config/wezterm/.background")

    local nvim_light_or_dark = get_var_from_file(os.getenv("HOME") .. "/.config/nvim/.background")
    local opacity = 0.92
    if nvim_light_or_dark == 'light' then
        opacity = 0.84
    end

    if background_image == "NONE" or background_image == nil then
        return {}
    elseif background_image == "TRANSPARENT" then
        return {
            {
                source = {
                    -- Use the current color scheme's background color as the only layer and add an opacity.
                    -- This allows anything under the terminal to show through while retaining the look and feel of the color scheme.
                    Color = wezterm.get_builtin_color_schemes()[config.color_scheme].background
                },
                opacity = opacity,
                -- height and width needed due to https://github.com/wez/wezterm/issues/2817
                height = '100%',
                width = '100%',
            },
        }
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
                opacity = opacity,
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

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true
config.window_close_confirmation = 'NeverPrompt'
config.initial_rows = 40
config.initial_cols = 140
config.window_padding = { left = 0, right = 0, top = 20, bottom = 0 }

-- and finally, return the configuration to wezterm
return config
