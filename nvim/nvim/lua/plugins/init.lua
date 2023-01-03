return {

    -- Greeter
    {
        'goolord/alpha-nvim',
        dependencies= { 'kyazdani42/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    },

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
        lazy = true,
        keys = {
            { "<leader>ts", ":TSPlaygroundToggle<CR>" },
        },
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
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
            },
        },
        lazy = true,
        keys = {
            { "<leader>f ", "<cmd>lua require('telescope.builtin').resume()<cr>" },
            { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>" },
            { "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>" },
            { "<leader>fj", "<cmd>lua require('telescope.builtin').grep_string()<cr>" },
            { "<leader>fe", "<cmd>lua require('telescope.builtin').oldfiles()<cr>" },
            { "<leader>fo", "<cmd>lua require('telescope.builtin').jumplist()<cr>" },
            { "<leader>fh", "<cmd>lua require('telescope.builtin').diagnostics()<cr>" },
            { "<leader>fl", "<cmd>lua require('telescope.builtin').loclist()<cr>" },
            { "<leader>f?", "<cmd>lua require('telescope.builtin').keymaps()<cr>" },
            { "<leader>fr", "<cmd>lua require('telescope.builtin').registers()<cr>" },
            { "<leader>fB", "<cmd>lua require('telescope.builtin').buffers()<cr>" },
            { "<leader>fv", "<cmd>lua require('telescope.builtin').help_tags()<cr>" },
            { "<leader>fm", "<cmd>lua require('telescope.builtin').man_pages()<cr>" },
            { "<leader>fk", "<cmd>lua require('telescope.builtin').live_grep({search_dirs = require('plugins.configs.telescope').getqflist_files(), results_title = 'Quickfix Files'})<cr>" },
            { "<leader>fK", "<cmd>lua require('telescope.builtin').quickfix()<cr>" },
            { "<leader>fc", "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>" },
            { "<leader>fd", "<cmd>lua require('telescope.builtin').git_status()<cr>" },
            { "<leader>db", "<cmd>lua require('telescope.builtin').git_branches()<cr>" },
            { "<leader>dc", "<cmd>lua require('telescope.builtin').git_commits()<cr>" },
            { "<leader>fa", "<cmd>lua require('plugins.configs.telescope').ff_playground()<cr>" },
            { "<leader>fs", "<cmd>lua require('plugins.configs.telescope').lg_playground()<cr>" },
            { "<leader>.", "<cmd>lua require('telescope').extensions.tmuxinator.projects(require('telescope.themes').get_dropdown({}))<cr>" },
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

    'justinmk/vim-sneak',

    -- Git
    {
        'lewis6991/gitsigns.nvim',
        dependencies= { 'petertriho/nvim-scrollbar', },
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
        dependencies= { 'nvim-lua/plenary.nvim', },
        lazy = false,
        keys = {
            { '<leader>dd', ':DiffviewOpen<cr>', desc = "Diff View" },
            { '<leader>df', ':DiffviewFileHistory %<cr>', desc = "Diff View with current buffer commit history" },
            { '<leader>dF', ':DiffviewFileHistory<cr>', desc = "Diff View with full repo commit history" },
            { '<leader>dx', ':DiffviewClose<cr>', desc = "Diff View close" }
        },
        config = require('plugins.configs.diffview').setup
    },
    {
        'tpope/vim-fugitive',
        lazy = true,
        keys = {
            { '<leader>gB', ':Git blame<cr>', desc = "Git Blame in separate split" }
        },
    },

    -- File Tree
    {
        'kyazdani42/nvim-tree.lua',
        dependencies= { 'kyazdani42/nvim-web-devicons', },
        lazy = true,
        keys = {
            {
                '<leader>aa',
                function()
                    vim.cmd('NvimTreeFindFile')  -- Open tree to current buffer.
                    vim.cmd('NvimTreeOpen')  -- Call open again incase there was no current buffer.
                end,
                desc = "File Tree Open"
            },
            { '<leader>ax', ':NvimTreeClose<CR>', desc = "File Tree Close" },
        },
        config = require('plugins.configs.nvim-tree').setup
    },

    -- Symbol Outline
    {
        'simrat39/symbols-outline.nvim',
        lazy = true,
        keys = {
            { "<leader>ss", ":SymbolsOutlineOpen<CR>", desc = "Symbols Outline Open" },
            { "<leader>sx", ":SymbolsOutlineClose<CR>", desc = "Symbols Outline Close" },
        },
        config = function ()
            require("symbols-outline").setup({
                width = 20,
                autofold_depth = 1,
                -- TODO: remove once https://github.com/simrat39/symbols-outline.nvim/pull/191/files is merged.
                symbols = {
                    File = {hl = "@text.uri" },
                    Module = {hl = "@namespace" },
                    Namespace = {hl = "@namespace" },
                    Package = {hl = "@namespace" },
                    Class = {hl = "@type" },
                    Method = {hl = "@method" },
                    Property = {hl = "@method" },
                    Field = {hl = "@field" },
                    Constructor = {hl = "@constructor" },
                    Enum = {hl = "@type" },
                    Interface = {hl = "@type" },
                    Function = {hl = "@function" },
                    Variable = {hl = "@constant" },
                    Constant = {hl = "@constant" },
                    String = {hl = "@string" },
                    Number = {hl = "@number" },
                    Boolean = {hl = "@boolean" },
                    Array = {hl = "@constant" },
                    Object = {hl = "@type" },
                    Key = {hl = "@type" },
                    Null = {hl = "@type" },
                    EnumMember = {hl = "@field" },
                    Struct = {hl = "@type" },
                    Event = {hl = "@type" },
                    Operator = {hl = "@operator" },
                    TypeParameter = {hl = "@parameter" },
                },
            })
        end,
    },

    -- Tmux
    {
        'alexghergh/nvim-tmux-navigation',
        lazy = true,
        keys = {
            { "<C-h>", '<cmd> lua require("nvim-tmux-navigation").NvimTmuxNavigateLeft()<CR>', mode = { "n", "v", "i", "x" } },
            { "<C-j>", '<cmd> lua require("nvim-tmux-navigation").NvimTmuxNavigateDown()<CR>', mode = { "n", "v", "i", "x" } },
            { "<C-k>", '<cmd> lua require("nvim-tmux-navigation").NvimTmuxNavigateUp()<CR>', mode = { "n", "v", "i", "x" } },
            { "<C-l>", '<cmd> lua require("nvim-tmux-navigation").NvimTmuxNavigateRight()<CR>', mode = { "n", "v", "i", "x" } },
        },
    },
    {
        'christoomey/vim-tmux-runner',
        config = require('plugins.configs.vim-tmux-runner').setup,
    },


    -- Buffer tabs
    {
        'akinsho/bufferline.nvim',
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
        lazy = true,
        keys = {
            { "<leader>ji", ":BrowserSearch<cr>", desc = "Search for word under cursor in browser" },
            { "<leader>ji", ":'<,'>BrowserSearch<cr>", desc = "Search for visual selection in brower" },
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

    -- Buffer deletion without changing layout
    {
        'famiu/bufdelete.nvim',
        lazy = false,
        keys = {
            { '<leader>q', ':Bdelete<cr>' },
            { '<leader>Q', ':Bdelete!<cr>' }
        },
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
        lazy = true,
        keys = {
            { "<leader>mo", "<cmd> lua require('peek').open()<cr>", desc = "Markdown preview open" },
            { "<leader>mx", "<cmd> lua require('peek').close()<cr>", desc = "Markdown preview close" }
        },
        config = function()
            require("peek").setup()
        end
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
    {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.completion.spell,
                },
            })
        end,
    },
    -- Debug  TODO: lazy load
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
        dependencies= {
          "MunifTanjim/nui.nvim",
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope.nvim"
        },
        lazy = true,
        keys = {
            { "<leader>cb", ':ChatGPT<CR>', desc = "ChatGPT prompt" }
        },
        config = function ()
            require("chatgpt").setup({
                welcome_message = ""
            })
        end
    },

    -- TODO: set this up again.
    -- Project specific setup scripts
    --require('projects.bde-airflow').setup()

}
