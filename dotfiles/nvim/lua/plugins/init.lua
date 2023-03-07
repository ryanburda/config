return {

    -- Greeter
    {
        'goolord/alpha-nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    },

    -- Color Schemes
    {
        'EdenEast/nightfox.nvim',
        dependencies = { 'jacoborus/tender.vim', 'ellisonleao/gruvbox.nvim', 'NLKNguyen/papercolor-theme' },
        config = require('plugins.configs.colorscheme').setup,
    },

    {
        'Aasim-A/scrollEOF.nvim',
        config = function() require('scrollEOF').setup() end,
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        config = require('plugins.configs.treesitter').setup,
    },
    {
        'nvim-treesitter/playground',
        lazy = true,
        keys = {
            { "<leader>ts", ":TSPlaygroundToggle<CR>" },
        },
    },
    'nvim-treesitter/nvim-treesitter-context',

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
            'freestingo/telescope-changed-files',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
            },
        },
        config = require('plugins.configs.telescope').setup
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

    -- Motion
    'justinmk/vim-sneak',

    -- Git
    {
        'lewis6991/gitsigns.nvim',
        dependencies = { 'petertriho/nvim-scrollbar', },
        config = require('plugins.configs.gitsigns').setup
    },
    {
        'ruifm/gitlinker.nvim',
        lazy = true,
        keys = {
            { "<leader>gl", "<cmd>lua require('gitlinker').get_buf_range_url('n')<cr>", desc = "Github link of current location in buffer" },
            { "<leader>gl", "<cmd>lua require('gitlinker').get_buf_range_url('v')<cr>v`<", desc = "Github link of current visual selection", mode = {"v"} },
            { "<leader>gh", "<cmd>lua require('gitlinker').get_buf_range_url('n', {action_callback = require('gitlinker.actions').open_in_browser})<cr>", desc = "Open Github in browser to current location in buffer" },
            { "<leader>gh", "<cmd>lua require('gitlinker').get_buf_range_url('v', {action_callback = require('gitlinker.actions').open_in_browser})<cr>v`<", desc = "Open Github in brower to current visual selection", mode = {"v"} },
        },
    },
    {
        'sindrets/diffview.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', },
        config = require('plugins.configs.diffview').setup
    },
    {
        'tpope/vim-fugitive',
        keys = {
            { '<leader>gB', ':Git blame<cr>', desc = "Git Blame in separate split" }
        },
    },

    -- File Tree
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = { 'kyazdani42/nvim-web-devicons', },
        config = require('plugins.configs.nvim-tree').setup
    },

    -- Symbol Outline
    {
        'simrat39/symbols-outline.nvim',
        config = require('plugins.configs.symbols-outline').setup
    },

    -- Tmux
    {
        'mrjones2014/smart-splits.nvim',
        config = require('plugins.configs.smart-splits').setup,
    },
    {
        'christoomey/vim-tmux-runner',
        config = require('plugins.configs.vim-tmux-runner').setup,
    },


    -- Buffer tabs
    {
        'akinsho/bufferline.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons', },
        config = require('plugins.configs.bufferline').setup,
    },

    -- Buffer deletion without changing layout
    {
        'famiu/bufdelete.nvim',
        dependencies = { 'akinsho/bufferline.nvim', },
        config = require("plugins.configs.bufdelete").setup
    },

    -- Status line
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons', },
        config = require('plugins.configs.lualine').setup
    },

    {
        'folke/trouble.nvim',
        dependencies = { "kyazdani42/nvim-web-devicons", },
        lazy = true,
        keys = {
            { "<leader>hh", ":Trouble<cr>", desc = "Trouble diagnostics open" },
            { "<leader>hx", ":TroubleClose<cr>", desc = "Trouble diagnostics close" },
        },
        config = function() require("trouble").setup() end
    },

    -- Web Search
    {
        'voldikss/vim-browser-search',
        lazy = true,
        keys = {
            { "<leader>ji", ":BrowserSearch<cr>", desc = "Search for word under cursor in browser" },
            { "<leader>ji", ":'<,'>BrowserSearch<cr>", desc = "Search for visual selection in brower", mode = {"v"} },
        },
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

    -- Floating Terminal
    {
        'akinsho/toggleterm.nvim',
        config = require("plugins.configs.toggleterm").setup
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
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "folke/neodev.nvim", },
        config = require("plugins.configs.mason-lspconfig").setup
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "williamboman/mason.nvim",
        },
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
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
    {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    --null_ls.builtins.diagnostics.flake8,
                },
            })
        end,
    },
    -- Debug
    {
        'mfussenegger/nvim-dap',
        dependencies = {
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
        dependencies = {
            'mfussenegger/nvim-dap',
        },
    },

    -- Github Copilot
    {
        'zbirenbaum/copilot.lua',
        dependencies = { "zbirenbaum/copilot-cmp", },
        lazy = true,
        keys = {
            { "<leader>ai", ":lua require('plugins.configs.copilot').toggle()<cr>", desc = "Github Copilot Toggle" },
        },
        config = require('plugins.configs.copilot').setup,
    },
    {
        "zbirenbaum/copilot-cmp",
        lazy = true,
        config = function ()
            require("copilot_cmp").setup()
        end
    },

    -- ChatGPT
    {
        "jackMort/ChatGPT.nvim",
        dependencies = {
          "MunifTanjim/nui.nvim",
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope.nvim"
        },
        lazy = false,
        keys = {
            { "<leader>cb", ':ChatGPT<CR>', desc = "ChatGPT prompt" }
        },
        config = function ()
            require("chatgpt").setup({
                welcome_message = ""
            })
        end
    },

}
