local wezterm = require("wezterm")
local config = wezterm.config_builder()

local function get_var_from_file(file_path, default)
    -- Reads value from `file_path`, returns `default` if file does not exist.
    local file, _ = io.open(file_path, "r")
    if not file then
        -- Could not open file
        return default
    end

    local content = file:read("*a")

    -- Remove trailing new lines
    content = content:gsub("%s*$", "")

    file:close()
    return content
end

local function get_background_config()
    local background_image = get_var_from_file(os.getenv("HOME") .. "/.config/wezterm/.background", 'NONE')
    local nvim_light_or_dark = get_var_from_file(os.getenv("HOME") .. "/.config/nvim/.background", 'dark')

    local opacity = 0.90
    if nvim_light_or_dark == 'light' then
        opacity = 0.83
    end

    local background_config = {}

    if background_image == "NONE" then
        return background_config
    end

    -- Lay the image down first if one was selected.
    if background_image ~= "TRANSPARENT" then
        table.insert(background_config, {
            source = {
                File = os.getenv("HOME") .. "/.config/wezterm/backgrounds/" .. background_image
            },
        })
    end

    -- Layer the current color scheme's background color and add an opacity.
    -- This allows any layers below to show through while retaining the look and feel of the color scheme.
    table.insert(background_config, {
        source = {
            Color = wezterm.get_builtin_color_schemes()[config.color_scheme].background
        },
        opacity = opacity,
        -- height and width needed due to https://github.com/wez/wezterm/issues/2817
        height = '100%',
        width = '100%',
    })

    return background_config

end

-- NOTE: `os.getenv("XDG_CONFIG_HOME")` returns nil. Using "HOME" as an alternative for now.
config.color_scheme = get_var_from_file(os.getenv("HOME") .. "/.config/wezterm/.colorscheme", 'Batman')
config.font = wezterm.font(get_var_from_file(os.getenv("HOME") .. "/.config/wezterm/.font", 'JetBrains Mono'))
config.font_size = tonumber(get_var_from_file(os.getenv("HOME") .. "/.config/wezterm/.font_size", '12'))
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
