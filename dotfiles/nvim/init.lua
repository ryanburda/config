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
-- pumheight should always be 2 less than scrolloff.
-- pumheigth sets the number of results in nvim-cmp.
-- +2 accounts for the padding of the nvim-cmp floating window.
-- scrolloff determines how many blank rows are padded below the last actual line of the buffer when scrolling down.
-- This ensures that nvim-cmp always shows up below cursor even when scrolled to the bottom of the buffer.
vim.opt.pumheight = 6
vim.opt.scrolloff = 8
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
vim.opt.listchars = { tab = '›~'}
vim.opt.autoread = true
vim.opt.winbar = '%=%m %f'
vim.o.statuscolumn = "%s%4l %2r  "

vim.cmd('set noshowmode')
vim.cmd('set noswapfile')

-- Open help window in a vertical split to the right.
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("help_window_right", {}),
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

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = "rounded"
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = "rounded"
    }
)

vim.diagnostic.config({
    virtual_text = true,
    float = {
        border = "rounded",
        focusable = false,
        scope = "line",
    },
})

-- Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup(require("plugins"))

-- Local plugins
require('quickfix')
require('auto_close_buf').setup()

-- Keymaps
require('keymaps')

-- Project specific setup scripts
require('projects.bde-airflow').setup()
require('projects.finance-datamart').setup()
