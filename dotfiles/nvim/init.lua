require('pipe').setup()

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
vim.opt.showmatch = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.mouse = "a"
vim.opt.mousemoveevent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.whichwrap = '<,>,h,l,[,]'
vim.opt.timeoutlen = 1000
vim.opt.updatetime = 100
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"
vim.opt.list = true
vim.opt.listchars = { tab = '›~'}
vim.opt.autoread = true
vim.opt.winbar = "%=%f"

vim.cmd('set noshowmode')
vim.cmd('set noswapfile')


-- keymap
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap=true, silent=false }
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', '<leader><S-Tab>', ':tabprevious<cr>'    , opts)
vim.keymap.set('n', '<leader><Tab>'  , ':tabnext<cr>'        , opts)
vim.keymap.set('n', '<leader>J'      , ':split<cr><C-w>j'    , opts)
vim.keymap.set('n', '<leader>L'      , ':vsplit<cr><C-w>l'   , opts)
vim.keymap.set('n', '<C-f>'          , 'zLgm'                , opts)  -- horizontal scroll right
vim.keymap.set('n', '<C-b>'          , 'zHgm'                , opts)  -- horizontal scroll left
vim.keymap.set('n', 'n'              , 'nzz'                 , opts)  -- next occurrence of search and center
vim.keymap.set('n', 'N'              , 'Nzz'                 , opts)  -- previous occurrence of search and center
vim.keymap.set('n', '<leader>p'      , '"0p'                 , opts)  -- paste from yank register
vim.keymap.set('n', '<leader>P'      , '"0P'                 , opts)  -- paste from yank register
vim.keymap.set('n', '<leader>u'      , ':e #<cr>'            , opts)  -- open last closed buffer
vim.keymap.set('n', '<leader>0'      , ':%bd|e#|bd#<cr>'     , {desc = 'Close all buffers except current'})
vim.keymap.set('n', '<leader>z'      , ':!open -a "Google Chrome" %<cr><cr>', {desc = 'Open current file in browser'})

-- quick notes
vim.keymap.set('n', '<leader>n' , ':edit ~/Documents/main.txt<cr>G$', opts)

-- :help vim.diagnostic.*
vim.keymap.set('n', '<leader>hj', '<cmd>lua vim.diagnostic.goto_next()<CR>' , opts)
vim.keymap.set('n', '<leader>hk', '<cmd>lua vim.diagnostic.goto_prev()<CR>' , opts)

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
