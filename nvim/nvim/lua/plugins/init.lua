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
        config = function() require('plugins.configs.treesitter').setup() end,
        run = ':TSUpdate'
    }
    use {
        'sainnhe/everforest',
        config = function() require('plugins.configs.everforest').setup() end
    }

    use '4513ECHO/vim-colors-hatsunemiku'

    -- File explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function() require('plugins.configs.nvim-tree').setup() end
    }

    -- Greeter
    use {
        'goolord/alpha-nvim',
        config = function() require("plugins.configs.alpha").setup() end
    }

    -- Luasnip
    use 'L3MON4D3/LuaSnip'

    -- Code completion
    use {
        'hrsh7th/nvim-cmp',
        config = function() require('plugins.configs.cmp').setup() end
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
            config = function() require("plugins.configs.lsp").setup() end
        }
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        },
        config = function() require('plugins.configs.telescope').setup() end
    }

    -- Tmux
    use {
        'christoomey/vim-tmux-navigator',
        config = function() require('plugins.configs.vim-tmux-navigator').setup() end
    }
    use {
        'christoomey/vim-tmux-runner',
        config = function() require('plugins.configs.vim-tmux-runner').setup() end
    }

    -- Git
    use {
        'tpope/vim-fugitive',
        config = function() require('plugins.configs.vim-fugitive').setup() end
    }
    use {
        'airblade/vim-gitgutter',
        config = function() require('plugins.configs.gitgutter').setup() end
    }
    use {
        'ruifm/gitlinker.nvim',
        config = function() require('plugins.configs.gitlinker').setup() end
    }
    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require('plugins.configs.diffview').setup() end
    }

    -- Status line
    use {
        'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require('plugins.configs.bufferline').setup() end
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons'},
        config = function() require('plugins.configs.lualine').setup() end
    }
    use 'nvim-lua/lsp-status.nvim'

    -- Web Search
    use {
        'voldikss/vim-browser-search',
        config = function() require('plugins.configs.vim-browser-search').setup() end
    }

    -- buffer deletion
    use 'famiu/bufdelete.nvim'

    -- commands on top of the sqls lsp
    use 'nanotee/sqls.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end

end)

vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins/init.lua source <sfile> | PackerCompile
    augroup end
]])
