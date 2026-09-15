--[[

Sets the colorscheme based on environment variables

--]]
local envy = require('envy')

local colorscheme = envy.get('nvim_colorscheme', 'everforest')
local background = envy.get('nvim_background', 'dark')

vim.cmd('colorscheme ' .. colorscheme)
vim.cmd('set background=' .. background)

-- Transparency
if envy.get('wezterm_background', 'NONE') ~= "NONE" then
  -- These highlight groups should be made transparent when displaying a background.
  vim.cmd("highlight Normal guibg=none ctermbg=none")
  vim.cmd("highlight NormalNC guibg=none ctermbg=none")
  vim.cmd("highlight NormalFloat guibg=none ctermbg=none")
  vim.cmd("highlight NonText guibg=none ctermbg=none")
end
