vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins/init.lua source <sfile> | PackerCompile
    augroup end
]])

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
        config = require('plugins.configs.treesitter').setup,
        run = ':TSUpdate'
    }
    use {
        'sainnhe/everforest',
        config = require('plugins.configs.everforest').setup
    }

    use '4513ECHO/vim-colors-hatsunemiku'

    -- File explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = require('plugins.configs.nvim-tree').setup
    }

    -- Greeter
    use {
        'goolord/alpha-nvim',
        config = require("plugins.configs.alpha").setup
    }

    -- lsp
    use {
        "williamboman/nvim-lsp-installer",
        {
            "neovim/nvim-lspconfig",
            requires = {
                "hrsh7th/nvim-cmp"
            },
            config = require("plugins.configs.lsp").setup
        }
    }
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lua',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'ray-x/lsp_signature.nvim',
            '~/Developer/src/nvim/plugins/lsp-status.nvim',
            'nanotee/sqls.nvim',
        },
        config = require('plugins.configs.cmp').setup
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        },
        config = require('plugins.configs.telescope').setup
    }

    -- Tmux
    use {
        'christoomey/vim-tmux-navigator',
        config = require('plugins.configs.vim-tmux-navigator').setup
    }
    use {
        'christoomey/vim-tmux-runner',
        config = require('plugins.configs.vim-tmux-runner').setup
    }

    -- Git
    use {
        'kdheepak/lazygit.nvim',
        config = require('plugins.configs.lazygit').setup
    }
    use {
        'tpope/vim-fugitive',
        config = require('plugins.configs.vim-fugitive').setup
    }
    use {
        'airblade/vim-gitgutter',
        config = require('plugins.configs.gitgutter').setup
    }
    use {
        'ruifm/gitlinker.nvim',
        config = require('plugins.configs.gitlinker').setup
    }
    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = require('plugins.configs.diffview').setup
    }

    -- Status line
    use {
        'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'kyazdani42/nvim-web-devicons',
        config = require('plugins.configs.bufferline').setup
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons'},
        config = require('plugins.configs.lualine').setup
    }

    -- Web Search
    use {
        'voldikss/vim-browser-search',
        config = require('plugins.configs.vim-browser-search').setup
    }

    -- buffer deletion
    use 'famiu/bufdelete.nvim'

    -- motion
    use 'justinmk/vim-sneak'

    -- file explorer
    use {
        'ptzz/lf.vim',
        requires = 'voldikss/vim-floaterm',
        config = require('plugins.configs.lf').setup
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end

end)
