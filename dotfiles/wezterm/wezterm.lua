local helpers = require("helpers")
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- important paths
-- NOTE: `os.getenv("XDG_CONFIG_HOME")` returns nil. Using "HOME" as an alternative for now.
local background_image_dir =      os.getenv("HOME") .. "/.config/wezterm/backgrounds/"
local background_file_path =      os.getenv("HOME") .. "/.config/wezterm/.background"
local color_scheme_file_path =    os.getenv("HOME") .. "/.config/wezterm/.colorscheme"
local font_file_path =            os.getenv("HOME") .. "/.config/wezterm/.font"
local font_size_file_path =       os.getenv("HOME") .. "/.config/wezterm/.font_size"
local nvim_background_file_path = os.getenv("HOME") .. "/.config/nvim/.background"

config.color_scheme = helpers.get_var_from_file(color_scheme_file_path, 'Batman')
config.font = wezterm.font(helpers.get_var_from_file(font_file_path, 'JetBrains Mono'))
config.font_size = tonumber(helpers.get_var_from_file(font_size_file_path, '12'))
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

-- BACKGROUND
--
-- the value in `background_file_path` can be one of the following:
--     - 'NONE': if no background image or color layer should be shown. (default background)
--     - 'TRANSPARENT': the current colorschemes background will be rendered semi transparent
--          to allow any windows under the terminal to show through.
--     - <Image path>: The leaf of the image path relative to `background_image_dir` that will be shown.
--          Similar to 'TRANSPARENT', the current colorschemes background will be rendered
--          semi transparent to allow the image to show through.
local current_background = helpers.get_var_from_file(background_file_path , "NONE")
local background_image_path = nil

if current_background ~= nil and current_background ~= "TRANSPARENT" and current_background ~= "NONE" then
    background_image_path =  background_image_dir .. current_background
end

local background_color = nil

if current_background ~= "NONE" then
    background_color = wezterm.get_builtin_color_schemes()[config.color_scheme].background
end

local is_nvim_background_dark = (helpers.get_var_from_file(nvim_background_file_path, 'dark')) == 'dark'
local opacity

if is_nvim_background_dark then
    opacity = 0.90
else
    opacity = 0.83
end

config.background = helpers.get_background_config(background_image_path, background_color, opacity)

return config
