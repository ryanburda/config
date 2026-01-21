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
--   local c = "#2f3a3a"
--   vim.cmd("highlight StatusLineNC guibg=" .. c)
--   vim.cmd("highlight SignColumn guibg=" .. c)
--   vim.cmd("highlight LineNr guibg=" .. c)
--   vim.cmd("highlight CursorLineNr guibg=" .. c)
-- elseif colorscheme == 'iceberg' and background == 'dark' then
--   local c = "#1f2132"
--   vim.cmd("highlight StatusLineNC guifg=" .. c)
-- elseif colorscheme == 'darkearth' and background == 'dark' then
--   local c = "#181715"
--   vim.cmd("highlight StatusLineNC guibg=" .. c)
--   vim.cmd("highlight SignColumn guibg=" .. c)
--   vim.cmd("highlight LineNr guibg=" .. c)
--   vim.cmd("highlight CursorLineNr guibg=" .. c)
--   vim.cmd("highlight LineNrAbove guibg=" .. c)
-- end

-- Transparency
if env.envget('wezterm_background', 'NONE') ~= "NONE" then
  -- These highlight groups should be made transparent when displaying a background.
  vim.cmd("highlight Normal guibg=none ctermbg=none")
  vim.cmd("highlight NormalNC guibg=none ctermbg=none")
  vim.cmd("highlight NormalFloat guibg=none ctermbg=none")
  vim.cmd("highlight NonText guibg=none ctermbg=none")
end
