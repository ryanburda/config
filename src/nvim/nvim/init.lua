-- OPTIONS
vim.cmd('colorscheme everforest')

vim.wo.wrap = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.cc = '120'
vim.opt.encoding = 'UTF-8'
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.showmatch = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.mouse = "a"
vim.opt.clipboard = 'unnamedplus'
vim.opt.whichwrap = '<,>,h,l,[,]'
vim.opt.timeoutlen = 2000
vim.opt.updatetime = 500

-- command! BufOnly execute '%bdelete|edit #|normal `"'
vim.api.nvim_create_user_command(
    'BufOnly',
    'execute \'%bdelete|edit#|normal`"\'',
    {}
)

-- KEYMAP
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap('n', 'Y'         , 'yy'                  , opts)
vim.api.nvim_set_keymap('n', '<leader>w' , ':w<cr>'              , opts)
vim.api.nvim_set_keymap('n', '<leader>q' , ':bd<cr>'             , opts)
vim.api.nvim_set_keymap('n', '<leader>Q' , ':bd!<cr>'            , opts)
vim.api.nvim_set_keymap('n', '<leader>0' , ':BufOnly<cr>'        , opts)
vim.api.nvim_set_keymap('n', '<leader>x' , ':q<cr>'              , opts)
vim.api.nvim_set_keymap('n', '<leader>X' , ':q!<cr>'             , opts)
vim.api.nvim_set_keymap('n', '<leader>l' , ':bnext<cr>'          , opts)
vim.api.nvim_set_keymap('n', '<leader>h' , ':bprevious<cr>'      , opts)
vim.api.nvim_set_keymap('n', '<leader>H' , ':tabprevious<cr>'    , opts)
vim.api.nvim_set_keymap('n', '<leader>L' , ':tabnext<cr>'        , opts)
vim.api.nvim_set_keymap('n', '<leader>t' , ':tab split<cr>'      , opts)
vim.api.nvim_set_keymap('n', '<leader>v' , 'V'                   , opts)
vim.api.nvim_set_keymap('n', '<leader>V' , '{v}'                 , opts)
vim.api.nvim_set_keymap('n', '<leader>/' , ':source $MYVIMRC<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>;' , ':split<cr><C-w>j'    , opts)
vim.api.nvim_set_keymap('n', '<leader>\'', ':vsplit<cr><C-w>l'   , opts)

-- :help vim.diagnostic.*
vim.api.nvim_set_keymap('n', '<leader>df', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dk', '<cmd>lua vim.diagnostic.goto_prev()<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>dj', '<cmd>lua vim.diagnostic.goto_next()<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>dl', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- :help quickfix
vim.api.nvim_set_keymap('n', '<leader> o', ':copen<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader> x', ':cclose<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader> j', ':cnext<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader> k', ':cprev<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader> f', ':cfirst<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader> l', ':clast<CR>' , opts)

-- OTHER
require('plugins')
require('lsp')
-- quick notes
vim.api.nvim_set_keymap('n', '<leader>n' , ':edit ~/Developer/scratch/notes/main.txt<cr>G$', opts)
