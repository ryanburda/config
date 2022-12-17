local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)

    -- Packer can manage itself
    use {
        'wbthomason/packer.nvim',
        config = require('plugins.configs.packer-nvim').setup,
    }

    -- Greeter
    use {
        'goolord/alpha-nvim',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    }

    -- Color Schemes
    use {
        'EdenEast/nightfox.nvim',
        config = require('plugins.configs.colorscheme').setup,
    }

    use {
        'folke/styler.nvim',
        config = require('plugins.configs.styler').setup,
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        config = require('plugins.configs.treesitter').setup,
    }
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'nvim-treesitter/playground'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            'freestingo/telescope-changed-files',
        },
        config = require('plugins.configs.telescope').setup
    }

    -- Scrolling
    use {  -- Scrollbar
        'petertriho/nvim-scrollbar',
        config = function() require("scrollbar").setup() end
    }
    use {  -- Smooth scrolling
        'karb94/neoscroll.nvim',
        config = require('plugins.configs.neoscroll').setup
    }

    use 'justinmk/vim-sneak'

    -- Git
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'petertriho/nvim-scrollbar', },
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
    use {
        'tpope/vim-fugitive',
        config = require('plugins.configs.vim-fugitive').setup,
    }

    -- File Tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons', },
        config = require('plugins.configs.nvim-tree').setup
    }

    -- Tmux
    use {
        'alexghergh/nvim-tmux-navigation',
        config = require('plugins.configs.nvim-tmux-navigation').setup,
    }

    -- Buffer tabs
    use {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        requires = 'kyazdani42/nvim-web-devicons',
        config = require('plugins.configs.bufferline').setup,
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
    use {
        'RRethy/vim-illuminate',
        config = require('plugins.configs.vim-illuminate').setup
    }

    -- Indentation lines
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = require('plugins.configs.indent-blankline').setup
    }

    -- Buffer deletion without changing layout
    use {
        'famiu/bufdelete.nvim',
        config = require('plugins.configs.bufdelete').setup
    }

    -- Floating Terminal
    use {
        'akinsho/toggleterm.nvim',
        config = require("plugins.configs.toggleterm").setup
    }

    -- Markdown preview
    use {
        'toppair/peek.nvim',
        run = 'deno task --quiet build:fast',
        config = require("plugins.configs.peek").setup
    }

    ----------------------------
    -- Package Manager: Mason --
    ----------------------------
    local mason = require("plugins.configs.mason")
    use {
        "williamboman/mason.nvim",
        config = mason.setup,
        run = mason.install_daps
    }
    -- LSP
    use {
        "williamboman/mason-lspconfig.nvim",
        requires = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "folke/neodev.nvim", },
        config = require("plugins.configs.mason-lspconfig").setup
    }
    use {
        "neovim/nvim-lspconfig",
        requires = {
            "hrsh7th/nvim-cmp",
            "williamboman/mason.nvim",
        },
    }
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'nanotee/sqls.nvim',
            'onsails/lspkind.nvim',
        },
        config = require('plugins.configs.nvim-cmp').setup
    }
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

    -- Github Copilot
    use {
        'zbirenbaum/copilot.lua',
        opt = true,  -- only turn it on when you need it.
        config = require('plugins.configs.copilot').setup,
    }
    use {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function ()
            require("copilot_cmp").setup()
        end
    }
    require('plugins.configs.copilot').keymap()  -- Needs to outside of setup since plugin is optional.

    -- ChatGPT
    use({
        "jackMort/ChatGPT.nvim",
        config = require('plugins.configs.chatgpt').setup,
        requires = {
          "MunifTanjim/nui.nvim",
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope.nvim"
        }
    })

    -- Cheat.sh
    use {
        'RishabhRD/nvim-cheat.sh',
        requires = { 'RishabhRD/popfix', },
        config = require('plugins.configs.cheatsh').setup,
    }

    use {
        'eandrju/cellular-automaton.nvim',
        config = require('plugins.configs.cellular-automaton').setup,
    }

    -- Project specific setup scripts
    require('projects.bde-airflow').setup()

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end

end)
