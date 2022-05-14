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
vim.api.nvim_set_keymap('n', '<leader>v'      , 'V'                   , opts)
vim.api.nvim_set_keymap('n', '<leader>b'      , '{v}'                 , opts)
vim.api.nvim_set_keymap('n', '<leader>/'      , ':source $MYVIMRC<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>;'      , ':split<cr><C-w>j'    , opts)
vim.api.nvim_set_keymap('n', '<leader>\''     , ':vsplit<cr><C-w>l'   , opts)
vim.api.nvim_set_keymap('n', '<leader>p'      , '<C-w>p'              , opts)  -- previous split

-- quick notes
vim.api.nvim_set_keymap('n', '<leader>n' , ':edit ~/Developer/scratch/notes/main.txt<cr>G$', opts)

-- :help vim.diagnostic.*
vim.api.nvim_set_keymap('n', '<leader>Df', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>Dk', '<cmd>lua vim.diagnostic.goto_prev()<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>Dj', '<cmd>lua vim.diagnostic.goto_next()<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>Dl', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- :help quickfix
vim.api.nvim_set_keymap('n', '<leader>Ko', ':copen<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>Kx', ':cclose<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>Kj', ':cnext<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>Kk', ':cprev<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>Kf', ':cfirst<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>Kl', ':clast<CR>' , opts)

-- :help location-list
vim.api.nvim_set_keymap('n', '<leader>Lo', ':lopen<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>Lx', ':lclose<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>Lj', ':lnext<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>Lk', ':lprev<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader>Lf', ':lfirst<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>Ll', ':llast<CR>' , opts)

-- Packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

require("packer").startup(function(use)

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Highlighting & Colors
    use {
        'nvim-treesitter/nvim-treesitter',
        config = function() require('plugins.treesitter').setup() end,
        run = ':TSUpdate'
    }
    use {
        'sainnhe/everforest',
        config = function() require('plugins.everforest').setup() end
    }

    use '4513ECHO/vim-colors-hatsunemiku'

    -- File explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function() require('plugins.nvim-tree').setup() end
    }

    -- Greeter
    use {
        'goolord/alpha-nvim',
        config = function() require("plugins.alpha").setup() end
    }

    -- Luasnip
    use 'L3MON4D3/LuaSnip'

    -- Code completion
    use {
        'hrsh7th/nvim-cmp',
        config = function() require('plugins.cmp').setup() end
    }
    use {
        'hrsh7th/cmp-nvim-lsp',
        requires = 'hrsh7th/nvim-cmp'
    }
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lua'
    use 'saadparwaiz1/cmp_luasnip'
    use 'ray-x/lsp_signature.nvim'

    -- lsp
    use {
        "williamboman/nvim-lsp-installer",
        {
            "neovim/nvim-lspconfig",
            requires = { "hrsh7th/cmp-nvim-lsp" },
            config = function() require("plugins.lsp").setup() end
        }
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzy-native.nvim'
        },
        config = function() require('plugins.telescope').setup() end
    }

    -- Tmux
    use {
        'christoomey/vim-tmux-navigator',
        config = function() require('plugins.vim-tmux-navigator').setup() end
    }
    use {
        'christoomey/vim-tmux-runner',
        config = function() require('plugins.vim-tmux-runner').setup() end
    }

    -- Git
    use {
        'tpope/vim-fugitive',
        config = function() require('plugins.vim-fugitive').setup() end
    }
    use {
        'airblade/vim-gitgutter',
        config = function() require('plugins.gitgutter').setup() end
    }
    use {
        'ruifm/gitlinker.nvim',
        config = function() require('plugins.gitlinker').setup() end
    }
    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require('plugins.diffview').setup() end
    }

    -- Status line
    use {
        'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require('plugins.bufferline').setup() end
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons'},
        config = function() require('plugins.lualine').setup() end
    }
    use 'nvim-lua/lsp-status.nvim'

    -- Web Search
    use {
        'voldikss/vim-browser-search',
        config = function() require('plugins.vim-browser-search').setup() end
    }

    -- buffer deletion
    use 'famiu/bufdelete.nvim'

    -- commands on top of the sqls lsp
    use 'nanotee/sqls.nvim'

    -- Local Development
    use {
        '~/Developer/nvim/plugins/chtsh',
        config = function() require('plugins.chtsh').setup() end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end

end)
