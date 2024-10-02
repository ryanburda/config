local wezterm = require("wezterm")

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

-- NOTE: `os.getenv("XDG_CONFIG_HOME")` returns nil. Using "HOME" as an alternative for now.
config.color_scheme = get_var_from_file(os.getenv("HOME") .. "/.config/wezterm/.colorscheme")
config.font = wezterm.font(get_var_from_file(os.getenv("HOME") .. "/.config/wezterm/.font"))
config.font_size = tonumber(get_var_from_file(os.getenv("HOME") .. "/.config/wezterm/.font_size"))
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

return config
