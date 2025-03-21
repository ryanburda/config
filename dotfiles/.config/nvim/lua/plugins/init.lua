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
      "rose-pine/neovim",
    },
    config = require("config.colorscheme").setup,
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
  {
      "rachartier/tiny-inline-diagnostic.nvim",
      event = "VeryLazy", -- Or `LspAttach`
      priority = 1000, -- needs to be loaded in first
      config = function()
        require('tiny-inline-diagnostic').setup({
          preset = "modern",
          options = {
            break_line = {
              -- Enable the feature to break messages after a specific length
              enabled = false,
              -- Number of characters after which to break the line
              after = 30,
            },
          },
        })
        vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
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
    end,
    lazy = true,
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

  -- Fuzzy Finder
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      fzf_opts = {
        ['--cycle'] = true,
      },
      grep = {
        rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --glob=!.git",
      },
      winopts = {
        backdrop = 100,
        preview = {
          layout = "vertical",
          vertical = "down:50%",
        },
      },
      keymap = {
        builtin = {
          ['<C-u>'] = 'preview-page-up',
          ['<C-d>'] = 'preview-page-down',
          ['<C-k>'] = 'select-all+accept',
        },
        fzf = {
          ['ctrl-u'] = 'preview-page-up',
          ['ctrl-d'] = 'preview-page-down',
          ['ctrl-k'] = 'select-all+accept',
        },

      },
    },
  },

  {
    'Aasim-A/scrollEOF.nvim',
    config = function() require('scrollEOF').setup() end,
  },

  'justinmk/vim-sneak',

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

  {
    'mrjones2014/smart-splits.nvim',
    config = function ()
      require('smart-splits').setup({
        default_amount = 1,
        ignored_buftypes = { 'NvimTree', 'Outline' },
      })
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
    lazy = true,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
    lazy = true,
    config = require("config.nvim-dap-ui").setup
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    lazy = true,
    config = function() require("nvim-dap-virtual-text").setup({}) end
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
    lazy = true,
  },
  {
    'mfussenegger/nvim-dap-python',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    lazy = true,
  },

  -- sql
  {
    'nanotee/sqls.nvim',
    config = function() require('config.sqls').setup() end,
    lazy = true,
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
    dependencies = { 'kyazdani42/nvim-web-devicons', 'ibhagwan/fzf-lua', },
    config = function()
      require('bufs').setup()
    end,
  },

}
