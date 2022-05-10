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

vim.cmd('colorscheme everforest')

-- command! BufOnly execute '%bdelete|edit #|normal `"'
vim.api.nvim_create_user_command(
    'BufOnly',
    'execute \'%bdelete|edit#|normal`"\'',
    {}
)

-- keymap
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

-- quick notes
vim.api.nvim_set_keymap('n', '<leader>n' , ':edit ~/Developer/scratch/notes/main.txt<cr>G$', opts)

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

-- plugins
vim.cmd [[packadd packer.nvim]]

local packer = require("packer")

packer.startup(function(use)

    -- neovim package manager
    use 'wbthomason/packer.nvim'

    -- Highlighting & Colors
    use {
        'nvim-treesitter/nvim-treesitter',
        config = require('plugins.treesitter')
    }
    use 'sainnhe/everforest'
    use '4513ECHO/vim-colors-hatsunemiku'

    -- File explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = require('plugins.nvim-tree')
    }

    -- Greeter
    use {
        'goolord/alpha-nvim',
        config = require("plugins.alpha")
    }

    -- Luasnip
    use 'L3MON4D3/LuaSnip'

    -- lsp
    use {
        'williamboman/nvim-lsp-installer',
        {
            "neovim/nvim-lspconfig",
            config = require('lsp')
        }
    }

    -- Code completion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lua'
    use {
        'hrsh7th/nvim-cmp',
        config = require('plugins.cmp')
    }
    use 'saadparwaiz1/cmp_luasnip'
    use 'ray-x/lsp_signature.nvim'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzy-native.nvim'
        },
        config = require('plugins.telescope')
    }

    -- Tmux
    use {
        'christoomey/vim-tmux-navigator',
        config = require('plugins.vim-tmux-navigator')
    }
    use {
        'christoomey/vim-tmux-runner',
        config = require('plugins.vim-tmux-runner')
    }

    -- Git
    use {
        'tpope/vim-fugitive',
        config = require('plugins.vim-fugitive')
    }
    use {
        'airblade/vim-gitgutter',
        config = require('plugins.gitgutter')
    }
    use {
        'ruifm/gitlinker.nvim',
        config = require('plugins.gitlinker')
    }
    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = require('plugins.diffview')
    }

    -- Status line
    use {
        'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'kyazdani42/nvim-web-devicons',
        config = require('plugins.bufferline')
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons'},
        config = require('plugins.lualine')
    }
    use 'nvim-lua/lsp-status.nvim'

    -- Web Search
    use {
        'voldikss/vim-browser-search',
        config = require('plugins.vim-browser-search')
    }

    -- buffer deletion
    use 'famiu/bufdelete.nvim'

    -- commands on top of the sqls lsp
    use 'nanotee/sqls.nvim'

    -- Local Development
    use {
        '~/Developer/nvim/plugins/chtsh',
        config = require('plugins.chtsh')
    }

end)
