-- Defines all of the plugins that are managed by lazy.nvim.
--
-- The convention being followed in this repo is to put all plugins in the table below.
-- Lazy.nvim does allow for plugins to be definied in their own files but I generally
-- find it easier to track what plugins come in and out of use in the commit history
-- of a single file instead of the commit history of an entire directory.
-- This is a preference, not a requirement.

return {

  -- Color Schemes
  "sainnhe/everforest",
  "sainnhe/gruvbox-material",
  "EdenEast/nightfox.nvim",
  "rose-pine/neovim",
  "vague2k/vague.nvim",
  "fcancelinha/nordern.nvim",

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
        },
        sections = {
          lualine_a = {},
          lualine_c = { {'filename', path = 1}, },
          lualine_x = { require('trail_marker.extensions.info').info },
        },
      })
    end
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    config = function ()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup({
        max_lines = 2,
        multiline_threshold = 2,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })

      -- Use json parser for avro files.
      vim.filetype.add({
        extension = {
          avsc = "json",
        },
      })
    end
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require'treesitter-context'.setup{
        max_lines = 8,
        multiline_threshold = 1,
      }
    end,
  },

  -- Delete buffers without changing window layout.
  'ojroques/nvim-bufdel',

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
  },

  -- Oil.nvim
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      use_default_keymaps = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
      float = {
        max_width = .8,
        max_height = .8,
        preview_split = "below",
      },
    },
    dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
  },

  -- Fuzzy Finder
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function ()
      require('fzf-lua').setup({
        fzf_opts = {
          ['--cycle'] = true,
        },
        files = {
          actions = {
            ["ctrl-l"] = function(_, opts)
              local query = opts.query or ""
              require('fzf-lua').buffers({query=query})
            end,
            ["ctrl-s"] = function(_, opts)
              local query = opts.query or ""
              require('fzf-lua').oldfiles({query=query})
            end
          },
        },
        buffers = {
          actions = {
            ["ctrl-l"] = function(_, opts)
              local query = opts.query or ""
              require('fzf-lua').files({query=query})
            end
          },
        },
        oldfiles = {
          prompt = "Recent files > ",
          fzf_opts = {
            ["--header"] = string.format("<%s> to %s",
                                         require("fzf-lua.utils").ansi_codes.yellow("ctrl-s"),
                                         require("fzf-lua.utils").ansi_codes.red("files selector"))
          },
          actions = {
            ["ctrl-s"] = function(_, opts)
              local query = opts.query or ""
              require('files').files({query=query})
            end
          },
        },
        grep = {
          rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --glob=!.git",
        },
        git = {
          branches = {
            actions = {
              ["default"] = function(selected)
                local selected_branch = selected[1]:match("[^%s]+")
                if selected_branch then
                  -- Open DiffView with the selected branch
                  vim.cmd("DiffviewOpen " .. selected_branch)
                else
                  vim.notify("No branch selected!", vim.log.levels.WARN)
                end
              end,
              ["ctrl-l"] = function(selected)
                -- Get the current branch name
                local current_branch = vim.fn.systemlist("git symbolic-ref --short HEAD")[1]
                if not current_branch then
                  print("Not on a Git branch!")
                  return
                end

                -- Get the selected branch from fzf output
                local target_branch = selected[1]
                if not target_branch then
                  return
                end

                -- Trim leading and trailing whitespace and split by spaces
                local branch_split = vim.split(target_branch:match("^%s*(.-)%s*$"), "%s+")
                local selected_branch = branch_split[1]

                -- Run git diff to get the list of files changed between branches
                local diff_files_cmd = string.format("git diff --name-only %s..%s", current_branch, selected_branch)
                local diff_files = vim.fn.systemlist(diff_files_cmd)

                local preview_cmd = string.format(
                  "git diff %s..%s -- {} | delta",
                  current_branch,
                  selected_branch
                )

                -- Display the files using another fzf-lua picker
                require("fzf-lua").fzf_exec(diff_files, {
                  prompt = 'Diff Files> ',
                  preview = preview_cmd,
                  actions = {
                    ["default"] = function(selected_file)
                      if #selected_file == 0 then
                        vim.notify("No file selected!", vim.log.levels.WARN)
                        return
                      end

                      -- Open the selected file in a new buffer
                      local file_to_open = selected_file[1]

                      -- Use your preferred method to open the file. Here's an example:
                      vim.cmd("edit " .. file_to_open)
                    end,
                  },
                })
              end,
            },
            preview = "git diff --color=always $(git rev-parse --abbrev-ref HEAD)...{} | delta",
          },
          commits = {
            actions = {
              ["default"] = function(selected)
                local selected_branch = selected[1]:match("[^%s]+")
                if selected_branch then
                  -- Open DiffView with the selected branch
                  vim.cmd("DiffviewOpen " .. selected_branch)
                else
                  vim.notify("No branch selected!", vim.log.levels.WARN)
                end
              end,
              ["ctrl-l"] = function(selected)
                -- Get the current branch name
                local current_branch = vim.fn.systemlist("git symbolic-ref --short HEAD")[1]
                if not current_branch then
                  print("Not on a Git branch!")
                  return
                end

                -- Get the selected branch from fzf output
                local target_branch = selected[1]
                if not target_branch then
                  return
                end

                -- Trim leading and trailing whitespace and split by spaces
                local branch_split = vim.split(target_branch:match("^%s*(.-)%s*$"), "%s+")
                local selected_branch = branch_split[1]

                -- Run git diff to get the list of files changed between branches
                local diff_files_cmd = string.format("git diff --name-only %s..%s", current_branch, selected_branch)
                local diff_files = vim.fn.systemlist(diff_files_cmd)

                local preview_cmd = string.format(
                  "git diff %s..%s -- {} | delta",
                  current_branch,
                  selected_branch
                )

                -- Display the files using another fzf-lua picker
                require("fzf-lua").fzf_exec(diff_files, {
                  prompt = 'Diff Files> ',
                  preview = preview_cmd,
                  actions = {
                    ["default"] = function(selected_file)
                      if #selected_file == 0 then
                        vim.notify("No file selected!", vim.log.levels.WARN)
                        return
                      end

                      -- Open the selected file in a new buffer
                      local file_to_open = selected_file[1]

                      -- Use your preferred method to open the file. Here's an example:
                      vim.cmd("edit " .. file_to_open)
                    end,
                  },
                })
              end,
            },
            preview = "git diff --color=always $(git rev-parse --abbrev-ref HEAD)...{} | delta",
          },
        },
        winopts = {
          fullscreen = false,
          border = "rounded",
          backdrop = 100,
          preview = {
            border = "rounded",
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
      })

      -- custom buffer
      require('bufs').setup()

    end,
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
            height = 12,
          },
        },
        view = {
          merge_tool = {
            layout = "diff3_mixed",
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
    "mason-org/mason.nvim",
    opts = {}
  },

  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '1.*',
    opts = {
      keymap = {
        preset = 'default',
        ['<C-l>'] = { 'select_and_accept' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-j>'] = { 'snippet_backward', 'fallback' },
        ['<C-k>'] = { 'snippet_forward', 'fallback' },
        ['<C-h>'] = { 'show_signature', 'hide_signature', 'fallback' },
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
      },
      cmdline = {
        enabled = true,
        completion = {
          menu = {
            auto_show = true
          },
        },
      },
    },
  },

  -- Debug
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        "igorlfs/nvim-dap-view",
        opts = {
          winbar = {
            controls = {
              enabled = true,
            },
          },
          switchbuf = "usetab",
        }
      },
      {
        'theHamsta/nvim-dap-virtual-text',
        dependencies = {
          'mfussenegger/nvim-dap',
        },
        lazy = true,
        ---@diagnostic disable-next-line: missing-fields
        config = function() require("nvim-dap-virtual-text").setup({}) end
      },
    }
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
    config = function() require('sqls').setup() end,
  },
  {
    'hat0uma/csvview.nvim',
    config = function() require('csvview').setup() end,
  },

  -- Local plugins
  {
    dir = "~/Developer/trail_marker.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons', 'ibhagwan/fzf-lua', },
  },

}
