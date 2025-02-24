-- Defines all of the plugins that are managed by lazy.nvim.
--
-- The convention being followed in this repo is to put all plugins in the table below.
-- Lazy.nvim does allow for plugins to be definied in their own files but I generally
-- find it easier to track what plugins come in and out of use in the commit history
-- of a single file instead of the commit history of an entire directory.
-- This is a preference, not a requirement.
--
-- Plugins with larger than normal `config` functions (mason for example) can
-- have their config functions broken out into a separate file in `../config/`.

return {

  -- Greeter
  {
    'goolord/alpha-nvim',
    dependencies = { 'echasnovski/mini.icons' },
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
      "EdenEast/nightfox.nvim",
      "Verf/deepwhite.nvim",
      "ribru17/bamboo.nvim",
      "catppuccin/nvim",
      "AlexvZyl/nordic.nvim",
      "rose-pine/neovim",
      "savq/melange-nvim",
      {
        'comfysage/evergarden',
        priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
        opts = {
          transparent_background = true,
          variant = 'hard', -- 'hard'|'medium'|'soft'
          overrides = { }, -- add custom overrides
        }
      },
    },
    config = require("config.colorscheme").setup,
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
        ensure_installed = {
          "c",
          "go",
          "lua",
          "python",
          "query",
          "rust",
          "sql",
          "vim",
          "vimdoc",
        },
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
  -- autoformat on save
  {
    'stevearc/conform.nvim',
    config = function ()
      require("conform").setup({
        formatters_by_ft = {
          rust = { "rustfmt", lsp_format = "fallback" },
          go = { "gofmt" }
        },
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })
    end
  },

  -- Oil.nvim
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      use_default_keymaps = false,
      keymaps = {
        ["?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-h>"] = { "actions.parent", mode = "n" },
        ["<C-j>"] = { "j", mode = "n" },
        ["<C-k>"] = { "k", mode = "n" },
        ["<C-l>"] = "actions.select",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-s>"] = { "actions.change_sort", mode = "n" },
        ["<C-o>"] = { "actions.open_cwd", mode = "n" },
        ["<C-x>"] = "actions.open_external",
        ["<C-t>"] = { "actions.toggle_trash", mode = "n" },
        ["H"] = { "actions.toggle_hidden", mode = "n" },
        ["L"] = "actions.refresh",
        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
      },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
      float = {
        max_width = 100,
        max_height = 32,
        preview_split = "right",
      },
    },
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
  },

  -- File Finders
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      fzf_opts = {
        ['--cycle'] = true,
      },
      grep = {
        rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case",
      },
      winopts = {
        backdrop = 100,
        preview = {
          layout = "vertical",
          vertical = "down:60%",
        },
      },
      keymap = {
        builtin = {
          ['<C-u>'] = 'preview-page-up',
          ['<C-d>'] = 'preview-page-down',
        },
      },
    },
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
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
  -- NOTE: this is requiring folke/snacks.nvim
  -- {
  --   'tzachar/local-highlight.nvim',
  --   config = function()
  --     require('local-highlight').setup({
  --       animate = { enabled = false },
  --     })
  --   end
  -- },

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
    config = require('config.vim-tmux-runner').setup,
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
          custom_filter = function(buf, _)
            -- don't show quickfix buffers
            local buf_type = vim.bo[buf].bt
            if buf_type == 'quickfix' then
              return false
            end

            return true
          end,
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
    config = require('config.lualine').setup
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
    config = require("config.mason-lspconfig").setup
  },
  "williamboman/mason.nvim",

  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v0.*',
    opts = {
      keymap = {
        preset = 'default',
        ['<C-l>'] = { 'select_and_accept' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
      },
      completion = {
        menu = {
          border = "rounded",
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
          window = {
            border = "rounded",
          },
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      signature = {
        enabled = true,
        window = {
          border = 'rounded',
        },
      }
    },
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
    config = require("config.nvim-dap-ui").setup
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
    config = function() require('config.sqls').setup() end,
  },

  -- Github Copilot
  {
    'zbirenbaum/copilot.lua',
    dependencies = { "zbirenbaum/copilot-cmp", },
    lazy = true,
    config = require('config.copilot').setup,
  },
  {
    "zbirenbaum/copilot-cmp",
    lazy = true,
    config = function ()
      require("copilot_cmp").setup()
    end
  },

  -- Local plugins
  {
    dir = "~/Developer/trail_marker.nvim",
    dependencies = { 'kyazdani42/nvim-web-devicons', },
  },

}
