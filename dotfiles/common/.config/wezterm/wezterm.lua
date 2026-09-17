-- Add shared lua directory to package path
package.path = package.path .. ';' .. os.getenv('HOME') .. '/.config/lua/?.lua'

local envy = require("envy")
local wezterm = require("wezterm")
local colorschemes = require("colorschemes")
local config = wezterm.config_builder()

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
  -- Not one of ours; hope for a wezterm builtin of the same name.
  color_scheme = nvim_colorscheme
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

-- transparency
if envy.get('wezterm_transparency', 'false') == 'true' then
  config.window_background_opacity = 0.93
  if nvim_background ~= 'dark' then
    config.window_background_opacity = 0.87
  end
end

return config
