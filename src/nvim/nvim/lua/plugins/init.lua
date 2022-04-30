vim.cmd [[packadd packer.nvim]]

local packer = require("packer")

packer.startup(function(use)

    -- neovim package manager
    use 'wbthomason/packer.nvim'

    -- Highlighting & Colors
    use {
        'nvim-treesitter/nvim-treesitter',
        config = require('plugins.configs.treesitter')
    }
    use 'sainnhe/everforest'
    use '4513ECHO/vim-colors-hatsunemiku'


    -- File explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = require('plugins.configs.nvim-tree')
    }

    -- Greeter
    use {
        'goolord/alpha-nvim',
        config = require("plugins.configs.alpha")
    }

    -- Luasnip
    use 'L3MON4D3/LuaSnip'

    -- Code completion
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-cmdline'
    use 'saadparwaiz1/cmp_luasnip'
    use 'ray-x/lsp_signature.nvim'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzy-native.nvim'
        },
        config = require('plugins.configs.telescope')
    }

    -- Tmux
    use {
        'christoomey/vim-tmux-navigator',
        config = require('plugins.configs.vim-tmux-navigator')
    }
    use {
        'christoomey/vim-tmux-runner',
        config = require('plugins.configs.vim-tmux-runner')
    }

    -- Git
    use {
        'tpope/vim-fugitive',
        config = require('plugins.configs.vim-fugitive')
    }
    use {
        'airblade/vim-gitgutter',
        config = require('plugins.configs.gitgutter')
    }
    use {
        'ruifm/gitlinker.nvim',
        config = require('plugins.configs.gitlinker')
    }
    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = require('plugins.configs.diffview')
    }

    -- Status line
    use {
        'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'kyazdani42/nvim-web-devicons',
        config = require('plugins.configs.bufferline')
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons'},
        config = require('plugins.configs.lualine')
    }
    use 'nvim-lua/lsp-status.nvim'

    -- Web Search
    use {
        'voldikss/vim-browser-search',
        config = require('plugins.configs.vim-browser-search')
    }

    -- buffer deletion
    use 'famiu/bufdelete.nvim'

    -- commands on top of the sqls lsp
    use 'nanotee/sqls.nvim'

    -- Local Development
    use {
        '~/Developer/nvim/plugins/chtsh',
        config = require('plugins.configs.chtsh')
    }

end)

require('plugins.configs.cmp')
