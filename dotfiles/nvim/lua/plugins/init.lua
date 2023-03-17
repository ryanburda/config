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

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        config = function ()
            require('nvim-treesitter.configs').setup({
                auto_install = true,
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps =  {
                        node_incremental = '<C-n>',
                        node_decremental = '<C-p>',
                    },
                },
            })
        end
    },
    {
        'nvim-treesitter/playground',
        config = function ()
            vim.keymap.set('n', "<leader>ts", ":TSPlaygroundToggle<CR>")
        end
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
    {
        'Aasim-A/scrollEOF.nvim',
        config = function() require('scrollEOF').setup() end,
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
        config = function ()
            vim.keymap.set({'n', 'v'}, "<leader>gl", "<cmd>lua require('gitlinker').get_buf_range_url('n')<cr>", {desc = "Github link of current location in buffer"})
            vim.keymap.set({'n', 'v'}, "<leader>gh", "<cmd>lua require('gitlinker').get_buf_range_url('n', {action_callback = require('gitlinker.actions').open_in_browser})<cr>", {desc = "Open Github in browser to current location in buffer"})
        end
    },
    {
        'sindrets/diffview.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', },
        config = require('plugins.configs.diffview').setup
    },

    -- Symbol Outline
    {
        'simrat39/symbols-outline.nvim',
        config = require('plugins.configs.symbols-outline').setup
    },

    -- Tmux
    {
        'mrjones2014/smart-splits.nvim',
        config = function ()
            require('smart-splits').setup({
                default_amount = 1,
                ignored_buftypes = { 'NvimTree', 'Outline' },
            })
            vim.keymap.set({"n", "v", "i", "x"}, '<C-h>', require('smart-splits').move_cursor_left)
            vim.keymap.set({"n", "v", "i", "x"}, '<C-j>', require('smart-splits').move_cursor_down)
            vim.keymap.set({"n", "v", "i", "x"}, '<C-k>', require('smart-splits').move_cursor_up)
            vim.keymap.set({"n", "v", "i", "x"}, '<C-l>', require('smart-splits').move_cursor_right)
            vim.keymap.set({"n", "v", "i", "x"}, '<M-h>', require('smart-splits').resize_left)
            vim.keymap.set({"n", "v", "i", "x"}, '<M-j>', require('smart-splits').resize_down)
            vim.keymap.set({"n", "v", "i", "x"}, '<M-k>', require('smart-splits').resize_up)
            vim.keymap.set({"n", "v", "i", "x"}, '<M-l>', require('smart-splits').resize_right)
        end
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
        config = function ()
            vim.keymap.set('n', '<leader>q', ':Bdelete<cr>', {desc = 'Delete buffer without changing window layout'})
            vim.keymap.set('n', '<leader>Q', ':Bdelete!<cr>' , {desc = 'Force delete buffer without changing window layout'})
        end
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
        config = function ()
            require("trouble").setup()
            vim.keymap.set('n', "<M-f>", ":TroubleToggle<cr>", {desc = "Project Diagnostics Toggle" })
        end,
    },

    -- Web Search
    {
        'voldikss/vim-browser-search',
        config = function ()
            vim.keymap.set('n', "<leader>ji", ":BrowserSearch<cr>", {desc = "Search for word under cursor in browser"})
            vim.keymap.set('v', "<leader>ji", ":'<,'>BrowserSearch<cr>", {desc = "Search for visual selection in brower"})
        end
    },

    -- Highlight all occurrences of word under cursor
    {
        'RRethy/vim-illuminate',
        config = require('plugins.configs.vim-illuminate').setup
    },

    -- Indentation lines
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function ()
            require("indent_blankline").setup {
                space_char_blankline = " ",
                show_current_context = true,
            }
        end
    },

    ----------------------------
    -- Package Manager: Mason --
    ----------------------------
    {
        "williamboman/mason.nvim",
        config = function ()
            require("mason").setup()
            vim.keymap.set('n', '<leader>~', ':Mason<cr>')
        end
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
        config = function ()
            vim.keymap.set('n', '<M-b>', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", {desc = "Debug: Set breakpoint"})
            vim.keymap.set('n', '<M-c>', "<cmd>lua require'dap'.clear_breakpoints()<cr>", {desc = "Debug: Clear breakpoints"})
            vim.keymap.set('n', '<M-i>', "<cmd>lua require'dap'.step_into()<cr>"        , {desc = "Debug: Step into"})
            vim.keymap.set('n', '<M-o>', "<cmd>lua require'dap'.step_over()<cr>"        , {desc = "Debug: Step over"})
            vim.keymap.set('n', '<M-p>', "<cmd>lua require'dap'.continue()<cr>"         , {desc = "Debug: Continue to next breakpoint (Proceed)"})
        end
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
        'simrat39/rust-tools.nvim',
        dependencies = {
            'mfussenegger/nvim-dap',
        },
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

}
