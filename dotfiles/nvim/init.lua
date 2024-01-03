require('server').setup()

vim.wo.wrap = false
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.pumheight = 6  -- pumheight should be less than or equal to scrolloff
vim.opt.scrolloff = 6
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
vim.opt.updatetime = 500
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"
vim.opt.list = true
vim.opt.listchars = { tab = '›~'}
vim.opt.autoread = true
vim.opt.winbar = '%=%m %f'

vim.cmd('set noshowmode')
vim.cmd('set noswapfile')
vim.keymap.set('', '<Space>', '<NOP>', { noremap = true, silent = true })


-- keymap
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap=true, silent=false }
vim.keymap.set('v', 'J'              , ":m '>+1<CR>gv=gv" , {desc = 'Move visual selection down'})
vim.keymap.set('v', 'K'              , ":m '<-2<CR>gv=gv" , {desc = 'Move visual selection up'})
vim.keymap.set('n', '<leader><S-Tab>', ':tabprevious<cr>' , {desc = 'Previous Tab'})
vim.keymap.set('n', '<leader><Tab>'  , ':tabnext<cr>'     , {desc = 'Next Tab'})
vim.keymap.set('n', '<leader><C-k>'  , ':tabnew<cr>'      , {desc = 'New Tab'})
vim.keymap.set('n', '<leader><C-j>'  , ':split<cr><C-w>j' , {desc = 'Horizontal split'})
vim.keymap.set('n', '<leader><C-l>'  , ':vsplit<cr><C-w>l', {desc = 'Vertical split'})
vim.keymap.set('n', '<leader>x'      , ':q<cr>'           , {desc = 'Quit'})
vim.keymap.set('n', '<leader>X'      , ':qa<cr>'          , {desc = 'Quit all'})
vim.keymap.set('n', 'L'              , 'zLgm'             , {desc = 'horizontal scroll right'})
vim.keymap.set('n', 'H'              , 'zHgm'             , {desc = 'horizontal scroll left'})
vim.keymap.set('n', 'n'              , 'nzz'              , {desc = 'next occurrence of search and center'})
vim.keymap.set('n', 'N'              , 'Nzz'              , {desc = 'previous occurrence of search and center'})
vim.keymap.set('n', '<leader>p'      , '"0p'              , {desc = 'paste from yank register'})
vim.keymap.set('n', '<leader>P'      , '"0P'              , {desc = 'paste from yank register'})
vim.keymap.set('n', '<leader>0'      , ':%bd|e#|bd#<cr>'  , {desc = 'Close all buffers except current'})
vim.keymap.set('n', '<leader>m'      , ':!open -a "Google Chrome" %<cr><cr>', {desc = 'Open current file in browser'})
vim.keymap.set('n', '<leader>F'      , ":let @+=expand('%')<CR>", {desc = 'Copy relative file path to clipboard'})
vim.keymap.set('n', '<leader>A'      , ":let @+=expand('%:p')<CR>", {desc = 'Copy absolute file path to clipboard'})
vim.keymap.set('n', '<leader>D'      , ":let @+=expand('%:h')<CR>", {desc = 'Copy directory path to clipboard'})

-- quick notes
vim.keymap.set('n', '<leader>n' , ':edit ~/Documents/main.txt<cr>G$', opts)

-- :help vim.diagnostic.*
vim.keymap.set('n', '<leader>hj', '<cmd>lua vim.diagnostic.goto_next()<CR>' , opts)
vim.keymap.set('n', '<leader>hk', '<cmd>lua vim.diagnostic.goto_prev()<CR>' , opts)

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
    virtual_text = false,
    float = {
        border = "rounded",
        focusable = false,
        scope = "line",
    },
})

vim.keymap.set('n', '<leader>jo', '<cmd>lua vim.diagnostic.open_float()<CR>', {desc = 'Diagnostics: open float'})

require('quickfix').keymaps()
require('lf').keymaps()

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

vim.keymap.set('n', '<leader>`' , ':Lazy profile<CR>', {desc = 'Plugin Manager'})
