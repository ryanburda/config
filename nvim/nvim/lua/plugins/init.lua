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

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        config = require('plugins.configs.treesitter').setup,
        run = ':TSUpdate'
    }

    use 'nvim-treesitter/nvim-treesitter-context'

    -- Color Schemes
    use 'sainnhe/everforest'
    use 'lifepillar/vim-gruvbox8'
    use 'folke/tokyonight.nvim'

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

    -- LSP
    use {
        "williamboman/nvim-lsp-installer",
        requires = { "neovim/nvim-lspconfig" }
    }
    use {
        "neovim/nvim-lspconfig",
        requires = {
            "hrsh7th/nvim-cmp",
        },
        config = require("plugins.configs.lsp").setup
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

    -- Debugger
    --use {
    --    'mfussenegger/nvim-dap',
    --    requires = {
    --        'nvim-treesitter/nvim-treesitter',
    --        {
    --            'rcarriga/nvim-dap-ui',
    --            config = function() require("dapui").setup() end
    --        },
    --        {
    --            'theHamsta/nvim-dap-virtual-text',
    --            config = function() require("nvim-dap-virtual-text").setup() end
    --        },
    --        'mfussenegger/nvim-dap-python',
    --    },
    --    config = require('plugins.configs.nvim-dap').setup
    --}

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            --'mfussenegger/nvim-dap',
            --'nvim-telescope/telescope-dap.nvim',
            --{'Zane-/howdoi.nvim', config = require('plugins.configs.nvim-dap').setup},
        },
        config = require('plugins.configs.telescope').setup
    }

    -- Not sure if I'm gonna use this one.
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
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

    -- term
    use {
        'voldikss/vim-floaterm',
        config = require('plugins.configs.vim-floaterm').setup
    }

    -- Web Search
    use {
        'voldikss/vim-browser-search',
        config = require('plugins.configs.vim-browser-search').setup
    }

    -- Highlight all occurrences of word under cursor
    use 'RRethy/vim-illuminate'

    -- Buffer deletion
    use 'famiu/bufdelete.nvim'

    -- Motion
    use 'justinmk/vim-sneak'

    -- Scrolling
    use 'dstein64/nvim-scrollview'
    use {
        'karb94/neoscroll.nvim',
        config = function() require('neoscroll').setup() end
    }

    use 'lukas-reineke/indent-blankline.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end

end)
