return {

    -- Greeter
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    },

    -- Color Schemes
    {
        "rktjmp/fwatch.nvim",
        dependencies = {
            "sainnhe/everforest",
            "sainnhe/gruvbox-material",
            "rebelot/kanagawa.nvim",
            "EdenEast/nightfox.nvim",
            "Verf/deepwhite.nvim",
            "Mofiqul/vscode.nvim",
            "projekt0n/github-nvim-theme",
            "ribru17/bamboo.nvim",
            "sho-87/kanagawa-paper.nvim",
            {
                "zenbones-theme/zenbones.nvim",
                dependencies = {
                    "rktjmp/lush.nvim",
                },
            },
        },
        config = require("plugins.configs.colorscheme").setup,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require'colorizer'.setup({
                'css';
                'javascript';
                'toml';
                html = {
                    mode = 'foreground';
                }
            })
        end,
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        config = function ()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "rust", "sql" },
                sync_install = false,
                auto_install = true,
                ignore_install = {},
                highlight = {
                    enable = true,
                    -- disable treesitter highlight for large files
                    disable = function(_, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                },
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
        'nvim-treesitter/nvim-treesitter-context',
        config = function ()
            require('treesitter-context').setup({
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 4, -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 20, -- Maximum number of lines to show for a single context
                trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20, -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            })
        end
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({
                sources = { "filesystem", "document_symbols", },
                filesystem = {
                    follow_current_file = {enabled = true},
                },
                source_selector = {
                    winbar = true,
                    sources = {
                        { source = "filesystem", display_name = " 󰉓  Files " },
                        { source = "document_symbols", display_name = "   Symbols " },
                    },
                },
                default_component_configs = {
                    git_status = {
                        symbols = {
                            -- Change type
                            added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                            modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                            deleted   = "",-- this can only be used in the git_status source
                            renamed   = "",-- this can only be used in the git_status source
                            -- Status type
                            untracked = "",
                            ignored   = "",
                            unstaged  = "",
                            staged    = "",
                            conflict  = "",
                        },
                    },
                },
            })

            vim.keymap.set('n', "<M-a>", ":Neotree toggle<CR>")
        end
    },

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
            'freestingo/telescope-changed-files',
            'nvim-telescope/telescope-live-grep-args.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
            },
        },
        config = require('plugins.configs.telescope').setup
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

    -- Highlight word under cursor
    {
          'tzachar/local-highlight.nvim',
          config = function()
              require('local-highlight').setup({
                  hlgroup = 'Underlined',
                  cw_hlgroup = nil,
                  insert_mode = true,
              })
          end
    },

    -- Git
    {
        'lewis6991/gitsigns.nvim',
        config = require('plugins.configs.gitsigns').setup
    },
    {
        'ruifm/gitlinker.nvim',
        config = function ()
            vim.keymap.set({'n', 'v'}, "<leader>gl", "<cmd>lua require('gitlinker').get_buf_range_url('n')<cr>", {desc = "Github link of current location in buffer"})
            vim.keymap.set({'n', 'v'}, "<leader>gh", "<cmd>lua require('gitlinker').get_buf_range_url('n', {action_callback = require('gitlinker.actions').open_in_browser})<cr>", {desc = "Open Github in browser to current location in buffer"})
        end
    },
    'tpope/vim-fugitive',
    {
        'sindrets/diffview.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', },
        config = require('plugins.configs.diffview').setup
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

            require('auto_close_buf').setup()
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

    -- Indentation lines
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function ()
            require("ibl").setup {
                scope = {
                    show_start = false,
                    show_end = false
                }
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
        "williamboman/mason.nvim",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            'onsails/lspkind.nvim',
        },
        config = require('plugins.configs.nvim-cmp').setup
    },
    {
        'ray-x/lsp_signature.nvim',
        config = function(_, _)
            require'lsp_signature'.setup({})
            vim.keymap.set('n', '<C-m>', function() vim.lsp.buf.signature_help() end, {desc = "toggle signature (hold)"})
        end
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
            vim.keymap.set('n', '<M-x>', "<cmd>lua require'dap'.close()<cr>"            , {desc = "Debug: Closes the current debug session"})
            vim.keymap.set('n', '<M-Space>', "<cmd>lua require'dap'.run()<cr>"          , {desc = "Debug: Runs a new debug session"})
        end
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio',
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
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        ft = { 'rust' },
    },
    {
        'mfussenegger/nvim-dap-python',
        dependencies = {
            'mfussenegger/nvim-dap',
        },
    },

    -- sql
    "nanotee/sqls.nvim",
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-completion",
    "kristijanhusak/vim-dadbod-ui",
    {
        "kndndrj/nvim-dbee",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        build = function()
            -- Install tries to automatically detect the install method.
            -- if it fails, try calling it with one of these parameters:
            --    "curl", "wget", "bitsadmin", "go"
            require("dbee").install()
        end,
        config = function()
            require("dbee").setup(--[[optional config]])
            vim.keymap.set('n', '<M-d>', "<cmd>lua require('dbee').toggle()<cr>", {desc = "Toggle nvim-dbee"})
        end,
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
