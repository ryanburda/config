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

    -- Color Schemes
    use 'Mofiqul/vscode.nvim'
    -- use 'ellisonleao/gruvbox.nvim'
    -- use 'sainnhe/everforest'
    -- use 'folke/tokyonight.nvim'

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        config = require('plugins.configs.treesitter').setup,
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/nvim-treesitter-context'
    use {
        'lewis6991/spellsitter.nvim',
        requires = { 'nvim-treesitter/nvim-treesitter' },
        config = require('plugins.configs.spellsitter').setup,
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        },
        config = require('plugins.configs.telescope').setup
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
        'lewis6991/gitsigns.nvim',
        config = require('plugins.configs.gitsigns').setup
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

    -- Greeter
    use {
        'goolord/alpha-nvim',
        config = require("plugins.configs.alpha").setup
    }

    -- File Tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = require('plugins.configs.nvim-tree').setup
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

    -- Buffer tabs
    use {
        'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'kyazdani42/nvim-web-devicons',
        config = require('plugins.configs.bufferline').setup
    }

    -- Status line
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

    -- Highlight all occurrences of word under cursor
    use 'RRethy/vim-illuminate'

    -- Motion
    use 'justinmk/vim-sneak'

    -- Indentation lines
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = require('plugins.configs.indent-blankline').setup
    }

    -- Lists contents of file in right side gutter
    use {
        'simrat39/symbols-outline.nvim',
        config = require('plugins.configs.symbols-outline').setup
    }

    -- Close buffers
    use {
        'kazhala/close-buffers.nvim',
        config = require('plugins.configs.close-buffers').setup
    }

    -- Buffer deletion without changing layout
    use {
        'famiu/bufdelete.nvim',
        config = require('plugins.configs.bufdelete').setup
    }

    -- Scrolling
    use 'dstein64/nvim-scrollview'  -- Scrollbar
    use 'karb94/neoscroll.nvim'     -- Smooth scrolling


    ----------------------------
    -- Package Manager: Mason --
    ----------------------------
    use {
        "williamboman/mason.nvim",
        config = require("plugins.configs.mason").setup,
        run = require("plugins.configs.mason").install_daps
    }
    -- LSP
    use {
        "neovim/nvim-lspconfig",
        requires = {
            "hrsh7th/nvim-cmp",
        },
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
        config = require('plugins.configs.nvim-cmp').setup
    }
    use {
        "williamboman/mason-lspconfig.nvim",
        requires = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        config = require("plugins.configs.mason-lspconfig").setup
    }
    -- TODO: Use Mason to manage this
    -- Debug
    use {
        'mfussenegger/nvim-dap',
        requires = {
            'nvim-treesitter/nvim-treesitter',
        },
        config = require('plugins.configs.nvim-dap').setup
    }
    use {
        'rcarriga/nvim-dap-ui',
        requries = {
            'mfussenegger/nvim-dap',
        },
        config = require("plugins.configs.nvim-dap-ui").setup
    }
    use {
        'theHamsta/nvim-dap-virtual-text',
        requries = {
            'mfussenegger/nvim-dap',
        },
        config = function() require("nvim-dap-virtual-text").setup() end
    }
    use {
        'mfussenegger/nvim-dap-python',
        requires = {
            'mfussenegger/nvim-dap',
        },
    }


    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end

end)
