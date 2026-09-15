-- Add shared lua directory to package path
package.path = package.path .. ';' .. os.getenv('HOME') .. '/.config/lua/?.lua'

local envy = require("envy")
local wezterm = require("wezterm")
local colorschemes = require("colorschemes")
local config = wezterm.config_builder()

-- important paths
-- NOTE: `os.getenv("XDG_CONFIG_HOME")` returns nil. Using "HOME" as an alternative for now.
local background_image_dir = os.getenv("HOME") .. "/code/assets/base/assets/backgrounds/"

-- COLORSCHEME
--
-- The terminal palette is keyed off the neovim colorscheme rather than carrying
-- a wezterm theme name of its own: `colorschemes.lua` holds one entry per
-- neovim colorscheme in `set_colorscheme`, keyed by
-- "<nvim_colorscheme>-<nvim_background>". Anything not found there falls back
-- to a wezterm builtin of the same name.
local nvim_colorscheme = envy.get('nvim_colorscheme', 'everforest')
local nvim_background = envy.get('nvim_background', 'dark')
local color_scheme = nvim_colorscheme .. '-' .. nvim_background

local scheme = colorschemes[color_scheme]
if scheme ~= nil then
  config.color_schemes = { [color_scheme] = scheme }
else
  color_scheme = nvim_colorscheme
  scheme = wezterm.color.get_builtin_schemes()[color_scheme]
end
config.color_scheme = color_scheme
config.font = wezterm.font(envy.get('font_family', 'JetBrains Mono'))
config.font_size = tonumber(envy.get('font_size', '12'))
-- NONE, not RESIZE: niri sets `prefer-no-csd` and draws its own border/focus
-- ring, but wezterm draws a client-side titlebar + border anyway and sizes its
-- buffer *outside* the compositor's allocated geometry, so the bottom rows get
-- clipped off screen. Regressed in the 20260716 (r869) Wayland backend rewrite.
config.window_decorations = "NONE"
if wezterm.target_triple:find("apple-darwin", 1, true) then
  config.window_decorations = "RESIZE"
end
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false
config.window_close_confirmation = 'NeverPrompt'
config.initial_rows = 40
config.initial_cols = 120
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
if current_background ~= "NONE" and current_background ~= "TRANSPARENT" then
  background_image_path = background_image_dir .. current_background
end

-- background color
local background_color = nil

if current_background ~= "NONE" then
  background_color = scheme.background
end

-- background opacity
local is_nvim_background_dark = nvim_background == 'dark'
local opacity

if is_nvim_background_dark then
  opacity = 0.96
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
