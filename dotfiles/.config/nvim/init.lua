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
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- scrolloff - Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 12
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
vim.opt.signcolumn = "yes"
vim.opt.list = true
vim.opt.listchars = { tab = '│ '}
vim.opt.autoread = true
vim.opt.winbar = '%=%m %f'
vim.opt.statuscolumn = "%s%4l %2r  "

vim.cmd('set noshowmode')
vim.cmd('set noswapfile')

-- Open help window in a vertical split to the right.
vim.api.nvim_create_augroup('HelpWin', { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = 'HelpWin',
  pattern = { "*.txt" },
  callback = function()
    if vim.o.filetype == 'help' then vim.cmd.wincmd("L") end
  end
})

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
  virtual_text = true,
  float = {
    border = "rounded",
    focusable = false,
    scope = "line",
  },
})

local function get_var_from_file(file_path, default)
  -- Reads value from `file_path`, returns `default` if file does not exist.
  local file, _ = io.open(file_path, "r")
  if not file then
    -- Could not open file
    return default
  end

  local content = file:read("*a")

  -- Remove trailing new lines
  content = content:gsub("%s*$", "")

  file:close()
  return content
end

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = {
    colorscheme = { get_var_from_file(os.getenv("HOME") .. "/.config/nvim/.colorscheme", "habamax") }
  },
  checker = {
    enabled = false, -- automatically check for plugin updates
  },
  change_detection = {
    enabled = true, -- automatically check for config file changes and reload the ui
    notify = false, -- get a notification when changes are found
  },
})

-- keymaps
require('keymaps')
