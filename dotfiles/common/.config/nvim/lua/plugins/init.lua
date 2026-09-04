-- Defines all of the plugins that are managed by lazy.nvim.
--
-- The convention being followed in this repo is to put all plugins in the table below.
-- Lazy.nvim does allow for plugins to be definied in their own files but I generally
-- find it easier to track what plugins come in and out of use in the commit history
-- of a single file instead of the commit history of an entire directory.
-- This is a preference, not a requirement.

return {

  -- Local plugins
  {
    --'ryanburda/buf-mark',
    name = "buf-mark",
    dir = "~/code/buf-mark/base",
    config = function()
      require('buf-mark').setup({
        keymaps = true,
        persist = true,
        status = {
          hl_current = 'CursorLineNr',
          hl_non_current = 'LineNr',
        }
      })
    end
  },
  {
    --'ryanburda/nvim-tmux-wm',
    name = "nvim-tmux-wm",
    dir = "~/code/nvim-tmux-wm/base",
  },

  -- Color Schemes
  'sainnhe/everforest',
  'sainnhe/gruvbox-material',
  'EdenEast/nightfox.nvim',
  'rose-pine/neovim',
  'vague2k/vague.nvim',
  'ptdewey/darkearth-nvim',
  'catppuccin/nvim',
  'T-b-t-nchos/Aquavium.nvim',

  -- greeter
  {
    "goolord/alpha-nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("alpha").setup(
        require("dashboard").config
      )
    end,
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    config = function ()
      require('nvim-treesitter').setup({
        auto_install = true,
      })

      -- Enable treesitter-based syntax highlighting.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
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
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      enabled = true,
      scope = {
        show_start = false,
        show_end = false,
      },
      indent = {
        char = '│',
      },
    },
  },
  -- Delete buffers without changing window layout.
  'ojroques/nvim-bufdel',

  -- Highlight word under cursor.
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").pause()
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
        max_width = .85,
        max_height = .85,
        preview_split = "right",
        border = "rounded",
      },
      preview_win = {
        preview_method = "load",
      },
      keymaps = {
        ["<C-d>"] = "actions.preview_scroll_down",
        ["<C-u>"] = "actions.preview_scroll_up",
        ["<C-h>"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
        ["<C-l>"] = false,
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
          ['--color'] = 'hl:red,hl+:bright-red',
          ['--layout'] = 'default',
        },
        files = {
          hidden = true,
          actions = {
            ["ctrl-b"] = function(_, opts)
              local query = opts.query or ""
              require('fzf-lua').buffers({query=query})
            end,
          },
        },
        buffers = {
          actions = {
            ["ctrl-f"] = function(_, opts)
              local query = opts.query or ""
              require('fzf-lua').files({query=query})
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
                local selected_branch = selected[1]:gsub("^[%s%*%+→>]+", ""):gsub("%s+$", "")
                if selected_branch ~= "" then
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
                if selected_branch == "+" or selected_branch == "*" then
                  selected_branch = branch_split[2]
                end

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
                if selected_branch == "+" or selected_branch == "*" then
                  selected_branch = branch_split[2]
                end

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
          preview = {
            border = "rounded",
            layout = "vertical",
            vertical = "up:60%",
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
    end,
  },

  {
    'Aasim-A/scrollEOF.nvim',
    config = function() require('scrollEOF').setup() end,
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
        ['<C-y>'] = { 'select_and_accept' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-h>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },
      completion = {
        menu = {
          border = "rounded",
          max_height = 8,
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
          window = {
            border = "rounded",
            max_height = 8,
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
        keymap = {
          ['<Left>'] = { },
          ['<Right>'] = { },
        },
      },
    },
    config = function(_, opts)
      require('blink.cmp').setup(opts)

      -- Pin the completion menu to the bottom left of the editor, with the
      -- documentation window directly to its right, instead of letting either
      -- follow the cursor and cover the code being edited.
      --
      -- blink.cmp exposes no options for this, so both `update_position`
      -- functions are replaced. Every caller looks them up on the module table
      -- at call time, so overriding here covers all of them. Cmdline
      -- completion keeps the default (cursor anchored) behavior.
      --
      -- Note that a float's `row`/`col` address its outer corner: the border is
      -- drawn inside them, and `get_height()`/`get_width()` count it.
      local menu = require('blink.cmp.completion.windows.menu')
      local docs = require('blink.cmp.completion.windows.documentation')
      local default_menu_position = menu.update_position
      local default_docs_position = docs.update_position

      -- one past the last screen row a float may use, i.e. the top of the
      -- statusline / cmdline
      local function floor()
        return vim.o.lines - vim.o.cmdheight - (vim.o.laststatus > 0 and 1 or 0)
      end

      menu.update_position = function()
        if vim.api.nvim_get_mode().mode == 'c' then return default_menu_position() end

        local win = menu.win
        if not win:is_open() then return end

        -- size from the content alone, not from the space around the cursor
        win:update_size()

        local row = math.max(floor() - win:get_height(), 0)

        -- editing near the bottom of the screen would leave the cursor behind
        -- the menu, which is the thing this is meant to avoid, so flip to the
        -- top. screenpos() reports 0 when it cannot resolve the position, so
        -- fall back to the window's own origin.
        local cursor = vim.fn.screenpos(0, vim.fn.line('.'), vim.fn.col('.')).row
        if cursor == 0 then cursor = vim.fn.win_screenpos(0)[1] + vim.fn.winline() - 1 end
        if cursor - 1 >= row then row = 0 end

        win:set_win_config({ relative = 'editor', row = row, col = 0 })

        -- repositions the documentation window against the menu
        menu.position_update_emitter:emit()
      end

      docs.update_position = function()
        if vim.api.nvim_get_mode().mode == 'c' then return default_docs_position() end

        local win = docs.win
        if not win:is_open() or not menu.win:is_open() then return end

        win:update_size()

        local menu_config = vim.api.nvim_win_get_config(menu.win:get_win())
        local border = win:get_border_size()
        local col = menu_config.col + menu.win:get_width()

        -- rather than render a sliver, give up if the menu leaves no room
        local width_left = vim.o.columns - col
        if width_left <= border.horizontal + 1 then return win:close() end
        if win:get_width() > width_left then win:set_width(width_left - border.horizontal) end
        if win:get_height() > floor() then win:set_height(floor() - border.vertical) end

        -- share the menu's bottom edge, or its top edge when the menu flipped up
        local row = menu_config.row == 0 and 0
          or math.max(menu_config.row + menu.win:get_height() - win:get_height(), 0)

        win:set_win_config({ relative = 'editor', row = row, col = col })
      end
    end,
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

  {
    'nvim-telescope/telescope.nvim',
    branch = 'master',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('telescope').setup({
        defaults = {
          layout_strategy = 'vertical',
          layout_config = {
            width = 0.85,
            height = 0.85,
            preview_cutoff = 20,
          },
          border = true,
          sorting_strategy = 'ascending',
          prompt_prefix = '> ',
          selection_caret = '  ',
        },
      })
    end,
  },

  {
    'chentoast/marks.nvim',
    config = function()
      require('marks').setup({
        default_mappings = false,
      })
    end
  },

  'justinmk/vim-sneak',

}
