return {

    -- Greeter
    {
        'goolord/alpha-nvim',
        dependencies= { 'kyazdani42/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    },
    'kyazdani42/nvim-web-devicons',

    -- Color Schemes
    {
        'EdenEast/nightfox.nvim',
        config = require('plugins.configs.colorscheme').setup,
    },

    {
        'folke/styler.nvim',
        config = require('plugins.configs.styler').setup,
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        config = require('plugins.configs.treesitter').setup,
    },
    {
        'nvim-treesitter/playground',
        config = require('plugins.configs.treesitter_playground').setup,
    },
    'nvim-treesitter/nvim-treesitter-context',

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies= {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
            'freestingo/telescope-changed-files',
            'danielpieper/telescope-tmuxinator.nvim',
        },
        config = require('plugins.configs.telescope').setup
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    },

    -- Scrolling
    {  -- Scrollbar
        'petertriho/nvim-scrollbar',
        config = function() require("scrollbar").setup() end
    },
    {  -- Smooth scrolling
        'karb94/neoscroll.nvim',
        config = require('plugins.configs.neoscroll').setup
    },

    'justinmk/vim-sneak',

    -- Git
    {
        'lewis6991/gitsigns.nvim',
        dependencies= { 'petertriho/nvim-scrollbar', },
        config = require('plugins.configs.gitsigns').setup
    },
    {
        'ruifm/gitlinker.nvim',
        config = require('plugins.configs.gitlinker').setup
    },
    {
        'sindrets/diffview.nvim',
        dependencies= { 'nvim-lua/plenary.nvim', },
        config = require('plugins.configs.diffview').setup
    },
    {
        'tpope/vim-fugitive',
        config = require('plugins.configs.vim-fugitive').setup,
    },

    -- File Tree
    {
        'kyazdani42/nvim-tree.lua',
        dependencies= { 'kyazdani42/nvim-web-devicons', },
        config = require('plugins.configs.nvim-tree').setup
    },

    -- Tmux
    {
        'alexghergh/nvim-tmux-navigation',
        config = require('plugins.configs.nvim-tmux-navigation').setup,
    },
    {
        'christoomey/vim-tmux-runner',
        config = require('plugins.configs.vim-tmux-runner').setup,
    },


    -- Buffer tabs
    {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        dependencies= {'kyazdani42/nvim-web-devicons', },
        config = require('plugins.configs.bufferline').setup,
    },

    -- Status line
    {
        'nvim-lualine/lualine.nvim',
        dependencies= { 'kyazdani42/nvim-web-devicons', },
        config = require('plugins.configs.lualine').setup
    },

    -- Web Search
    {
        'voldikss/vim-browser-search',
        config = require('plugins.configs.vim-browser-search').setup
    },

    -- Highlight all occurrences of word under cursor
    {
        'RRethy/vim-illuminate',
        config = require('plugins.configs.vim-illuminate').setup
    },

    -- Indentation lines
    {
        'lukas-reineke/indent-blankline.nvim',
        config = require('plugins.configs.indent-blankline').setup
    },

    -- Buffer deletion without changing layout
    {
        'famiu/bufdelete.nvim',
        config = require('plugins.configs.bufdelete').setup
    },

    -- Floating Terminal
    {
        'akinsho/toggleterm.nvim',
        config = require("plugins.configs.toggleterm").setup
    },

    -- Markdown preview
    {
        'toppair/peek.nvim',
        run = 'deno task --quiet build:fast',
        config = require("plugins.configs.peek").setup
    },

    ----------------------------
    -- Package Manager: Mason --
    ----------------------------
    {
        "williamboman/mason.nvim",
        config = require("plugins.configs.mason").setup,
        run = require("plugins.configs.mason").install_daps
    },
    -- LSP
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies= { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "folke/neodev.nvim", },
        config = require("plugins.configs.mason-lspconfig").setup
    },
    {
        "neovim/nvim-lspconfig",
        dependencies= {
            "hrsh7th/nvim-cmp",
            "williamboman/mason.nvim",
            "j-hui/fidget.nvim",
        },
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies= {
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
    },
    -- Debug
    {
        'mfussenegger/nvim-dap',
        dependencies= {
            'nvim-treesitter/nvim-treesitter',
        },
        config = require('plugins.configs.nvim-dap').setup
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
        },
        config = require("plugins.configs.nvim-dap-ui").setup
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        dependencies = {
            'mfussenegger/nvim-dap',
        },
        config = function() require("nvim-dap-virtual-text").setup({}) end
    },
    {
        'mfussenegger/nvim-dap-python',
        dependencies= {
            'mfussenegger/nvim-dap',
        },
    },

    -- Github Copilot
    {
        'zbirenbaum/copilot.lua',
        lazy = true,
        keys = {
            { "<leader>ai", ":lua require('plugins.configs.copilot').toggle()<cr>", desc = "Github Copilot Toggle" },
        },
        config = require('plugins.configs.copilot').setup,
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function ()
            require("copilot_cmp").setup()
        end
    },

    -- ChatGPT
    {
        "jackMort/ChatGPT.nvim",
        config = require('plugins.configs.chatgpt').setup,
        dependencies= {
          "MunifTanjim/nui.nvim",
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope.nvim"
        }
    },

    -- Cheat.sh
    {
        'RishabhRD/nvim-cheat.sh',
        dependencies= { 'RishabhRD/popfix', },
        config = require('plugins.configs.cheatsh').setup,
    },

    {
        'eandrju/cellular-automaton.nvim',
        config = require('plugins.configs.cellular-automaton').setup,
    },

    -- Project specific setup scripts
    --require('projects.bde-airflow').setup()

}
