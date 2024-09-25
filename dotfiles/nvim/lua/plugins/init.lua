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
                "yorik1984/newpaper.nvim",
                config = true,
            },
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
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
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
                sources = { "filesystem" },
                filesystem = {
                    follow_current_file = {enabled = true},
                },
                source_selector = {
                    winbar = true,
                    statusline = false,
                    sources = {
                        { source = "filesystem", display_name = " 󰉓  Files " },
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
            {
                "aaronhallaert/advanced-git-search.nvim",
                cmd = { "AdvancedGitSearch" },
                config = function()
                    -- optional: setup telescope before loading the extension
                    require("telescope").setup{
                        -- move this to the place where you call the telescope setup function
                        extensions = {
                            advanced_git_search = {
                                    -- See Config
                                }
                        }
                    }
                    require("telescope").load_extension("advanced_git_search")
                end,
                dependencies = {
                    "nvim-telescope/telescope.nvim",
                    -- to show diff splits and open commits in browser
                    "tpope/vim-fugitive",
                    -- to open commits in browser with fugitive
                    "tpope/vim-rhubarb",
                    -- optional: to replace the diff from fugitive with diffview.nvim
                    -- (fugitive is still needed to open in browser)
                    -- "sindrets/diffview.nvim",
                },
            },
        },
        config = require('plugins.configs.telescope').setup
    },

    -- Scrolling
    'karb94/neoscroll.nvim',
    {
        'Aasim-A/scrollEOF.nvim',
        config = function() require('scrollEOF').setup() end,
    },
    {
        'petertriho/nvim-scrollbar',
        config = function() require("scrollbar").setup() end,
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
        config = function()
            require('gitsigns').setup({
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d>: <abbrev_sha> - <summary>',
            })
        end
    },
    'ruifm/gitlinker.nvim',
    'tpope/vim-fugitive',
    {
        'sindrets/diffview.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', },
        config = function()
            local actions = require("diffview.actions")

            require("diffview").setup({
                file_panel = {
                    win_config = {
                        position = "bottom",
                        height = 16,
                    },
                },
                keymaps = {
                    view = {
                        ["<leader>dh"] = actions.conflict_choose("ours"),
                        ["<leader>dl"] = actions.conflict_choose("theirs"),
                    },
                },
            })
        end,
    },

    -- Tmux
    {
        'mrjones2014/smart-splits.nvim',
        config = function ()
            require('smart-splits').setup({
                default_amount = 1,
                ignored_buftypes = { 'NvimTree', 'Outline' },
            })
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
        config = function ()
            require('bufferline').setup({
                options = {
                    close_command = "Bdelete",
                    show_close_icon = false,
                    show_buffer_close_icons = true,
                    offsets = {
                        {
                            filetype = "neo-tree",
                            highlight = "Directory",
                            separator = true -- use a "true" to enable the default, or set your own character
                        },
                    },
                    hover = {
                        enabled = true,
                        delay = 10,
                        reveal = {'close'}
                    },
                    separator_style = "thin",
                }
            })
        end
    },

    -- Buffer deletion without changing layout
    {
        'famiu/bufdelete.nvim',
        dependencies = { 'akinsho/bufferline.nvim', }
    },

    -- Status line
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons', },
        config = require('plugins.configs.lualine').setup
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
        end
    },

    -- Debug
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
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
    {
        'nanotee/sqls.nvim',
        config = function() require('plugins.configs.sqls').setup() end,
    },

    -- Github Copilot
    {
        'zbirenbaum/copilot.lua',
        dependencies = { "zbirenbaum/copilot-cmp", },
        lazy = true,
        keys = {
            { "<leader>ai", require('plugins.configs.copilot').toggle, desc = "Github Copilot Toggle" },
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
