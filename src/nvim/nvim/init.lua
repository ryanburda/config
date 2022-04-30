-- OPTIONS
vim.cmd('colorscheme everforest')

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

-- command! BufOnly execute '%bdelete|edit #|normal `"'
vim.api.nvim_create_user_command(
    'BufOnly',
    'execute \'%bdelete|edit#|normal`"\'',
    {}
)

-- KEYMAP
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap=true, silent=false }

vim.api.nvim_set_keymap('n', 'Y'              , 'yy'                  , opts)
vim.api.nvim_set_keymap('n', '<leader>w'      , ':w<cr>'              , opts)
vim.api.nvim_set_keymap('n', '<leader>q'      , ':Bdelete<cr>'        , opts)
vim.api.nvim_set_keymap('n', '<leader>Q'      , ':Bdelete!<cr>'       , opts)
vim.api.nvim_set_keymap('n', '<leader>0'      , ':BufOnly<cr>'        , opts)
vim.api.nvim_set_keymap('n', '<leader>x'      , ':q<cr>'              , opts)
vim.api.nvim_set_keymap('n', '<leader>X'      , ':q!<cr>'             , opts)
vim.api.nvim_set_keymap('n', '<leader>l'      , ':bnext<cr>'          , opts)
vim.api.nvim_set_keymap('n', '<leader>h'      , ':bprevious<cr>'      , opts)
vim.api.nvim_set_keymap('n', '<leader><S-Tab>', ':tabprevious<cr>'    , opts)
vim.api.nvim_set_keymap('n', '<leader><Tab>'  , ':tabnext<cr>'        , opts)
vim.api.nvim_set_keymap('n', '<leader>t'      , ':tab split<cr>'      , opts)
vim.api.nvim_set_keymap('n', '<leader>b'      , '{v}'                 , opts)
vim.api.nvim_set_keymap('n', '<leader>/'      , ':source $MYVIMRC<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>;'      , ':split<cr><C-w>j'    , opts)
vim.api.nvim_set_keymap('n', '<leader>\''     , ':vsplit<cr><C-w>l'   , opts)
vim.api.nvim_set_keymap('n', '<leader>p'      , '<C-w>p'              , opts)  -- previous split

-- :help vim.diagnostic.*
vim.api.nvim_set_keymap('n', '<leader>.f', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>.k', '<cmd>lua vim.diagnostic.goto_prev()<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>.j', '<cmd>lua vim.diagnostic.goto_next()<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>.l', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- :help quickfix
vim.api.nvim_set_keymap('n', '<leader>co', ':copen<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>cx', ':cclose<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>cj', ':cnext<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>ck', ':cprev<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>cf', ':cfirst<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>cl', ':clast<CR>' , opts)

-- :help location-list
vim.api.nvim_set_keymap('n', '<leader>vo', ':lopen<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>vx', ':lclose<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>vj', ':lnext<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>vk', ':lprev<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>vf', ':lfirst<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>vl', ':llast<CR>' , opts)

-- quick notes
vim.api.nvim_set_keymap('n', '<leader>n' , ':edit ~/Developer/scratch/notes/main.txt<cr>G$', opts)

-- TODO: move packer init here.
--       lsp and plugins would then just contain the config files and no init and no nested config dir.
-- other
require('plugins')
require('lsp')
