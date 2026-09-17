---@diagnostic disable: undefined-doc-name
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

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          component_separators = '',
          section_separators = '',
          globalstatus = true,
        },
        sections = {
          --lualine_a = {},
          lualine_b = {'filename'},
          lualine_c = {require('buf-mark.status').get},
          lualine_x = {'diagnostics'},
          lualine_y = {
            {
              'tabs',
              mode = 0,
              show_modified_status = false,
              cond = function() return vim.fn.tabpagenr('$') > 1 end,
            },
          },
          lualine_z = {},
        },
      })
    end,
  },

  -- Color Schemes
  'sainnhe/everforest',
  'sainnhe/gruvbox-material',
  'EdenEast/nightfox.nvim',
  'vague2k/vague.nvim',
  'catppuccin/nvim',
  'AlexvZyl/nordic.nvim',
  { 'zenbones-theme/zenbones.nvim', dependencies = { 'rktjmp/lush.nvim' } },
  'thesimonho/kanagawa-paper.nvim',

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
  -- code actions
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      -- optional picker via telescope
      {"nvim-telescope/telescope.nvim"},
      -- optional picker via fzf-lua
      {"ibhagwan/fzf-lua"},
      -- .. or via snacks
      {
        "folke/snacks.nvim",
        opts = {
          terminal = {},
        }
      }
    },
    event = "LspAttach",
    opts = {},
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
    dependencies = {
      'rafamadriz/friendly-snippets',
      { 'mikavilpas/blink-ripgrep.nvim', version = '*' },
    },
    version = '1.*',
    opts = {
      sources = {
        -- 'ripgrep' is appended to blink.cmp's default source list, so words
        -- found by ripgrep in the project show up alongside lsp/path/snippet/
        -- buffer results.
        default = { 'lsp', 'path', 'snippets', 'buffer', 'ripgrep' },
        providers = {
          ripgrep = {
            module = 'blink-ripgrep',
            name = 'Ripgrep',
            ---@module 'blink-ripgrep'
            ---@type blink-ripgrep.Options
            opts = {
              prefix_min_len = 3,
              project_root_marker = '.git',
              backend = {
                use = 'ripgrep',
                ripgrep = {
                  -- lines of context shown in the documentation window
                  context_size = 5,
                  max_filesize = '1M',
                  additional_rg_options = { '--hidden', '--glob=!.git' },
                },
              },
            },
            -- distinguish ripgrep results from the other sources in the menu
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                item.labelDetails = { description = '(rg)' }
              end
              return items
            end,
          },
        },
      },
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

      -- Pin the completion menu to one edge of the *current window*, with the
      -- documentation window directly to its right, instead of letting either
      -- follow the cursor and cover the code being edited. The pair sits at
      -- whichever horizontal edge of the window the cursor is furthest from --
      -- cursor in the top half puts them along the bottom, cursor in the
      -- bottom half puts them along the top -- so the line being edited always
      -- stays visible.
      --
      -- blink.cmp exposes no options for this, so both `update_position`
      -- functions are replaced. Every caller looks them up on the module table
      -- at call time, so overriding here covers all of them. Cmdline
      -- completion keeps the default (cursor anchored) behavior.
      --
      -- Note that a float's `row`/`col` address its outer corner: the border is
      -- drawn inside them, and `get_height()`/`get_width()` count it, while
      -- `set_height()`/`set_width()` take the inner content size.
      local menu = require('blink.cmp.completion.windows.menu')
      local docs = require('blink.cmp.completion.windows.documentation')
      local default_menu_position = menu.update_position
      local default_docs_position = docs.update_position

      -- both windows are held at this height no matter how much they hold, so
      -- they never resize under you as results come in, except when the space
      -- beside the cursor is too tight to fit it. `max_height` is only still
      -- read by the cmdline path below, which keeps blink's own sizing.
      local HEIGHT = opts.completion.menu.max_height

      -- The text area of the window being edited, as an editor-relative
      -- (0-indexed) box. `getwininfo()` is what makes this exact:
      -- `nvim_win_get_height()` counts the winbar as part of the window, so it
      -- would push everything one row down in any window that has one.
      local function get_pane()
        local info = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
        return {
          row = info.winrow - 1 + info.winbar,
          col = info.wincol - 1,
          height = info.height,
          width = info.width,
        }
      end

      -- The pane the menu last positioned itself against. The documentation
      -- window reuses it rather than measuring again, both so the two always
      -- agree and because it may be repositioned (on scroll, say) at a moment
      -- when the current window is not the one being edited.
      local pane

      -- the menu takes the left half of the pane, the docs window the right
      local function menu_box_width() return math.floor(pane.width / 2) end

      menu.update_position = function()
        if vim.api.nvim_get_mode().mode == 'c' then return default_menu_position() end

        local win = menu.win
        if not win:is_open() then return end

        pane = get_pane()
        local border = win:get_border_size()

        -- fixed width, rather than blink's fit-to-content and fit-to-the-space-
        -- around-the-cursor sizing
        win:set_width(math.max(menu_box_width() - border.horizontal, 1))

        -- Rows free on either side of the cursor line, which the menu is never
        -- allowed to cover. It goes to the roomier side, so the flip happens as
        -- the cursor crosses the middle of the window.
        local cursor = vim.fn.winline()
        local above, below = cursor - 1, pane.height - cursor
        local at_top = above > below

        -- shrink rather than overlap the cursor when that side is shallow; a
        -- window too short for even one row leaves the menu overlapping, as
        -- there is nowhere else for it to go
        win:set_height(math.max(math.min(HEIGHT, (at_top and above or below) - border.vertical), 1))

        local row = at_top and pane.row
          or math.max(pane.row + pane.height - win:get_height(), pane.row)

        win:set_win_config({ relative = 'editor', row = row, col = pane.col })

        -- repositions the documentation window against the menu
        menu.position_update_emitter:emit()
      end

      docs.update_position = function()
        if vim.api.nvim_get_mode().mode == 'c' then return default_docs_position() end

        local win = docs.win
        if not win:is_open() or not menu.win:is_open() or pane == nil then return end

        local menu_config = vim.api.nvim_win_get_config(menu.win:get_win())
        local border = win:get_border_size()
        local col = menu_config.col + menu.win:get_width()

        -- rather than render a sliver, give up if the menu leaves no room
        local width_left = pane.col + pane.width - col
        if width_left <= border.horizontal + 1 then return win:close() end

        win:set_width(width_left - border.horizontal)

        -- matching the menu's height lets it share the menu's row outright,
        -- whichever edge the menu settled on
        win:set_height(math.max(menu.win:get_height() - border.vertical, 1))

        win:set_win_config({ relative = 'editor', row = menu_config.row, col = col })
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
