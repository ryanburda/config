-- Setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- leader
vim.keymap.set('', '<Space>', '<NOP>', { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- options
vim.wo.wrap = false
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.numberwidth = 3
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- scrolloff - Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8
-- pumheight - Maximum number of items to show in a popup menu.
-- This should always be 2 less than scrolloff to ensure nvim-cmp completion popup always appears below the cursor
-- even when the cursor is at the very bottom of the screen. Subtracting 2 accounts for padding of the popup window.
vim.opt.pumheight = vim.opt.scrolloff:get() - 2
vim.opt.sidescrolloff = 12
vim.opt.cc = '120'
vim.opt.encoding = 'UTF-8'
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.showmatch = false
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.mouse = "a"
vim.opt.mousemoveevent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.whichwrap = '<,>,h,l,[,]'
vim.opt.timeoutlen = 1000
vim.opt.updatetime = 250
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes:2"
--vim.opt.signcolumn = "auto:3"
vim.opt.list = true
---@diagnostic disable-next-line: missing-fields
vim.opt.listchars = { tab = '│ '}
-- Thicker separator lines
vim.opt.fillchars = {
  horiz     = '━',
  horizup   = '┻',
  horizdown = '┳',
  vert      = '┃',
  vertleft  = '┫',
  vertright = '┣',
  verthoriz = '╋',
}
vim.opt.autoread = true
--vim.opt.winbar = '%=%m %t'
vim.opt.winbar = '%#StatusLineNC#%=%t %m%='

-- tabline
vim.opt.showtabline = 0  -- shown in lualine
function _G.tabline()
  return require('numbered_tabs_tabline').get_tabline_content()
end

-- buf-mark info in tabline
-- vim.opt.showtabline = 2  -- always show tabline
-- function _G.tabline()
--   local s = ''
--   s = s .. require('buf-mark.extras.info').get()
--   s = s .. require('numbered_tabs_tabline').get_tabline_content()
--   return s
-- end

vim.cmd('set noshowmode')
vim.cmd('set noswapfile')

-- Highlight when yanking text.
-- Try it with `yap` in normal mode
-- See: `:help.vim.highlihgt.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Rounded border around diagnostic float.
vim.diagnostic.config({
  virtual_text = false,
  float = {
    border = "rounded",
    focusable = false,
    scope = "line",
  },
})

vim.diagnostic.config({
  virtual_text = { current_line = true }
})

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  checker = {
    enabled = false, -- automatically check for plugin updates
  },
  change_detection = {
    enabled = true, -- automatically check for config file changes and reload the ui
    notify = false, -- get a notification when changes are found
  },
})

-- lsp
local lsp_configs = {}
for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
  local server_name = vim.fn.fnamemodify(f, ":t:r")
  table.insert(lsp_configs, server_name)
end
vim.lsp.enable(lsp_configs)

-- keymaps
require('keymaps')

-- set colorscheme
require("colorscheme")

-- vim.opt.tabline = '%!v:lua.tabline()'
-- vim.o.statusline = '%{%v:lua.require("buf-mark.status").get()%} %f %m'

-- external integrations.
-- the `integrations` directory is in the gitignore.
-- project specific lua files should be symlinked to this directory so they can be executed when nvim starts.
for _, f in pairs(vim.api.nvim_get_runtime_file("lua/plugins/integrations/*.lua", true)) do
  dofile(f)
end
