--[[

Sets the colorscheme based on environment variables

--]]
local envy = require('envy')

local colorscheme = envy.get('nvim_colorscheme', 'everforest')
local background = envy.get('nvim_background', 'dark')

vim.cmd('colorscheme ' .. colorscheme)
vim.cmd('set background=' .. background)

-- Per-colorscheme overrides.
--
-- These go after `background` is set, not before: changing it makes a
-- colorscheme reload and drop anything set earlier in this file.
if colorscheme == 'zenbones' and background == 'dark' then
  -- Change color column from muddy brown to gray.
  vim.cmd("highlight ColorColumn guibg=#25211f")
end

-- Transparency
if envy.get('wezterm_transparency', 'false') == 'true' then
  -- These highlight groups should be made transparent when the terminal is.
  vim.cmd("highlight Normal guibg=none ctermbg=none")
  vim.cmd("highlight NormalNC guibg=none ctermbg=none")
  vim.cmd("highlight NormalFloat guibg=none ctermbg=none")
  vim.cmd("highlight NonText guibg=none ctermbg=none")
end
