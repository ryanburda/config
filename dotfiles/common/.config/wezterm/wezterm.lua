-- Add shared lua directory to package path
package.path = package.path .. ';' .. os.getenv('HOME') .. '/.config/lua/?.lua'

local envy = require("envy")
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- important paths
-- NOTE: `os.getenv("XDG_CONFIG_HOME")` returns nil. Using "HOME" as an alternative for now.
local background_image_dir = os.getenv("HOME") .. "/.config/.assets/backgrounds/"

config.color_scheme = envy.get('wezterm_colorscheme', 'Catppuccin Mocha')
config.font = wezterm.font(envy.get('font_family', 'JetBrains Mono'))
config.font_size = tonumber(envy.get('font_size', '12'))
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false
config.window_close_confirmation = 'NeverPrompt'
config.initial_rows = 40
config.initial_cols = 140
config.window_padding = { left = 0, right = 0, top = 20, bottom = 0 }
config.warn_about_missing_glyphs = false

-- BACKGROUND
--
-- the wezterm_background environment variable can be one of the following:
--   - 'NONE': if no background image or color layer should be shown. (default background)
--   - 'TRANSPARENT': the current colorschemes background will be rendered semi transparent
--       to allow any windows under the terminal to show through.
--   - <Image path>: The leaf of the image path relative to `background_image_dir` that will be shown.
--       Similar to 'TRANSPARENT', the current colorschemes background will be rendered
--       semi transparent to allow the image to show through.

-- background image
local current_background = envy.get("wezterm_background", "NONE")
local background_image_path = nil
if current_background ~= "NONE" then
  background_image_path =  background_image_dir .. current_background
end

-- background color
local background_color = nil

if current_background ~= "NONE" then
  background_color = wezterm.get_builtin_color_schemes()[config.color_scheme].background
end

-- background opacity
local is_nvim_background_dark = (envy.get('nvim_background', 'dark')) == 'dark'
local opacity

if is_nvim_background_dark then
  opacity = 0.95
else
  opacity = 0.92
end

-- background config
local background = {}

if background_image_path ~= nil then
  -- Lay the image down first.
  table.insert(
    background,
    {
      source = {
        File = background_image_path
      },
    }
  )
end

if background_color ~= nil then
  -- Add the color layer on top.
  table.insert(
    background,
    {
      source = {
        Color = background_color
      },
      opacity = opacity,
      -- height and width needed due to https://github.com/wez/wezterm/issues/2817
      height = '100%',
      width = '100%',
    }
  )
end

config.background = background

return config
