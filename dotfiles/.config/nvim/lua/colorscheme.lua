--[[

Sets the colorscheme based on environment variables

--]]
local env = require('env')

-- Callback function triggered on file change
vim.cmd('colorscheme ' .. env.envget('nvim_colorscheme', 'everforest'))
vim.cmd('set background=' .. env.envget('nvim_background', 'dark'))

if env.envget('wezterm_background', 'NONE') ~= "NONE" then
  -- These highlight groups should be made transparent when displaying a background.
  vim.cmd("highlight Normal guibg=none ctermbg=none")
  vim.cmd("highlight NormalNC guibg=none ctermbg=none")
  vim.cmd("highlight NormalFloat guibg=none ctermbg=none")
  vim.cmd("highlight NonText guibg=none ctermbg=none")
  vim.cmd("highlight NeoTreeNormal guibg=none ctermbg=none")
  vim.cmd("highlight NeoTreeNormalNC guibg=none ctermbg=none")
  vim.cmd("highlight NeoTreeEndOfBuffer guibg=none ctermbg=none")
end
