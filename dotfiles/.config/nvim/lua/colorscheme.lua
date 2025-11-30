--[[

Sets the colorscheme based on environment variables

--]]
local env = require('env')

local colorscheme = env.envget('nvim_colorscheme', 'everforest')
local background = env.envget('nvim_background', 'dark')

vim.cmd('colorscheme ' .. colorscheme)
vim.cmd('set background=' .. background)

-- Custom colorscheme overrides
-- if colorscheme == 'everforest' and background == 'dark' then
--   vim.cmd("highlight StatusLine guibg=#3a3a3a ctermbg=234")
--   vim.cmd("highlight StatusLineNC guibg=#3a3a3a ctermbg=234")
--   vim.cmd("highlight SignColumn guibg=#3a3a3a ctermbg=234")
--   vim.cmd("highlight lualine_c_normal guibg=#3a3a3a ctermbg=234")
-- end

-- Transparency
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
