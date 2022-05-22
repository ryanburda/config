vim.wo.wrap = false
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
vim.opt.timeoutlen = 1000
vim.opt.updatetime = 100

vim.cmd('set laststatus=3')
vim.cmd('set noswapfile')

-- keymap
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap=true, silent=false }

vim.api.nvim_set_keymap('n', 'Y'              , 'yy'                  , opts)
vim.api.nvim_set_keymap('n', 'L'              , 'zLgm'                , opts)
vim.api.nvim_set_keymap('n', 'H'              , 'zHgm'                , opts)
vim.api.nvim_set_keymap('n', '<leader>w'      , ':w<cr>'              , opts)
vim.api.nvim_set_keymap('n', '<leader>q'      , ':Bdelete<cr>'        , opts)
vim.api.nvim_set_keymap('n', '<leader>Q'      , ':Bdelete!<cr>'       , opts)
vim.api.nvim_set_keymap('n', '<leader>0'      , ':%bd|e#|bd#<cr>'     , opts)  -- Delete all buffers but current
vim.api.nvim_set_keymap('n', '<leader>z'      , ':noh<cr>'            , opts)
vim.api.nvim_set_keymap('n', '<leader>x'      , ':q<cr>'              , opts)
vim.api.nvim_set_keymap('n', '<leader>X'      , ':q!<cr>'             , opts)
vim.api.nvim_set_keymap('n', '<leader>i'      , ':bprevious<cr>'      , opts)
vim.api.nvim_set_keymap('n', '<leader>o'      , ':bnext<cr>'          , opts)
vim.api.nvim_set_keymap('n', '<leader><S-Tab>', ':tabprevious<cr>'    , opts)
vim.api.nvim_set_keymap('n', '<leader><Tab>'  , ':tabnext<cr>'        , opts)
vim.api.nvim_set_keymap('n', '<leader>t'      , ':tab split<cr>'      , opts)
vim.api.nvim_set_keymap('n', '<leader>v'      , 'V'                   , opts)
vim.api.nvim_set_keymap('n', '<leader>b'      , '{v}'                 , opts)
vim.api.nvim_set_keymap('n', '<leader>/'      , ':source $MYVIMRC<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>;'      , ':split<cr><C-w>j'    , opts)
vim.api.nvim_set_keymap('n', '<leader>\''     , ':vsplit<cr><C-w>l'   , opts)
vim.api.nvim_set_keymap('n', '<leader>p'      , '<C-w>p'              , opts)  -- previous split

-- quick notes
vim.api.nvim_set_keymap('n', '<leader>n' , ':edit ~/Documents/main.txt<cr>G$', opts)

-- :help vim.diagnostic.*
vim.api.nvim_set_keymap('n', '<leader>hh', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>hj', '<cmd>lua vim.diagnostic.goto_next()<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>hk', '<cmd>lua vim.diagnostic.goto_prev()<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>hl', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- :help quickfix
vim.api.nvim_set_keymap('n', '<leader>ko', ':copen<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>kx', ':cclose<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>kh', ':cfirst<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>kj', ':cnext<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>kk', ':cprev<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>kl', ':clast<CR>' , opts)

-- :help location-list
vim.api.nvim_set_keymap('n', '<leader>lo', ':lopen<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>lx', ':lclose<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>lh', ':lfirst<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>lj', ':lnext<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>lk', ':lprev<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>ll', ':llast<CR>' , opts)

require('plugins')
