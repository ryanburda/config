-- Keymaps in this file are grouped by purpose, not plugin.
--
-- For example, keymaps associated with diffs/version control currently use the following plugins:
--      * fzf-lua
--      * diffview
--      * gitsigns
-- and are all prefixed with '<leader>d*':
--      * '<leader>dr' - diff reset hunk. (gitsigns)
--      * '<leader>dd' - open diffview. (diffview)
--      * '<leader>db' - opens a branch picker in fzf-lua, selected entry is opened in diffview to
--                       show a diff between current code and selected branch. (fzf-lua + diffview)
--
-- This last example is important because declaring a keymap with two plugin dependencies outside the setup
-- functions of either plugin eliminates the need for plugin dependencies that exist solely for keymap creation.

------------------------------------------------------------------------------------------------------------------------
-- Window Management
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
  'n',
  '<leader>T',
  ':tabnew<cr>',
  {desc = 'Window Management: New Tab'}
)

vim.keymap.set(
  'n',
  '<leader>x',
  ':tabclose<cr>',
  {desc = 'Window Management: Close Tab'}
)

vim.keymap.set(
  'n',
  '<leader><S-Tab>',
  ':tabprevious<cr>',
  {desc = 'Window Management: Previous Tab'}
)

vim.keymap.set(
  'n',
  '<leader><Tab>',
  ':tabnext<cr>',
  {desc = 'Window Management: Next Tab'}
)

vim.keymap.set(
  'n',
  '<leader>j',
  ':split<cr><C-w>j',
  {desc = 'Window Management: Horizontal split'}
)

vim.keymap.set(
  'n',
  '<leader>l',
  ':vsplit<cr><C-w>l',
  {desc = 'Window Management: Vertical split'}
)

------------------------------------------------------------------------------------------------------------------------
-- Navigation
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
  'n',
  '<C-d>',
  function()
    vim.cmd('execute "normal! 16j"')
  end,
  { desc = "Scroll down" }
)

vim.keymap.set(
  'n',
  '<C-u>',
  function()
    vim.cmd('execute "normal! 16k"')
  end,
  { desc = "Scroll up" }
)

vim.keymap.set(
  'n',
  'L',
  'zLgm',
  {desc = 'Navigation: Horizontal scroll right'}
)

vim.keymap.set(
  'n',
  'H',
  'zHgm',
  {desc = 'Navigation: Horizontal scroll left'}
)

vim.keymap.set(
  'n',
  'n',
  'nzz',
  {desc = 'Navigation: Next occurrence of search and center'}
)

vim.keymap.set(
  'n',
  'N',
  'Nzz',
  {desc = 'Navigation: Previous occurrence of search and center'}
)

vim.keymap.set(
  'n',
  '<leader>0',
  ':%bd|e#|bd#<cr>',
  {desc = 'Navigation: Close all buffers except current'}
)

vim.keymap.set(
  'n',
  '<leader>N',
  ':edit ~/Documents/main.txt<cr>G$',
  {desc = "Navigation: Open notes file"}
)

------------------------------------------------------------------------------------------------------------------------
-- Clipboard
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
  'n',
  '<leader>p',
  '"0p',
  {desc = 'Clipboard: Paste from yank register (after)'}
)

vim.keymap.set(
  'n',
  '<leader>P',
  '"0P',
  {desc = 'Clipboard: Paste from yank register (before)'}
)

vim.keymap.set(
  'n',
  '<leader>fp',
  ':let @+ = expand("%")<CR>',
  {desc = 'Clipboard: Copy relative file path to clipboard'}
)

vim.keymap.set(
  'n',
  '<leader>fP',
  ':let @+ = expand("%:p")<CR>',
  {desc = 'Clipboard: Copy absolute file path to clipboard'}
)

vim.keymap.set(
  'n',
  '<leader>fn',
  ':let @+ = expand("%:t")<CR>',
  {desc = 'Clipboard: Copy file name to clipboard'}
)

------------------------------------------------------------------------------------------------------------------------
-- Browser
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
  'n',
  '<leader>O',
  ':!open -a "Google Chrome" %<cr><cr>',
  {desc = 'Browser: Open current file in browser'}
)

------------------------------------------------------------------------------------------------------------------------
-- Diff
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
  'n',
  '<leader>ds',
  function()
    if vim.o.diff == false then
      vim.cmd('windo diffthis')
    else vim.cmd('windo diffoff')
    end
  end,
  {desc = 'Diff: Toggle diff of current split'}
)

vim.keymap.set(
  {'n', 'v'},
  "<leader>gl",
  function()
    require('gitlinker').get_buf_range_url('n')
  end,
  {desc = "Diff: Github link of current location in buffer"}
)

vim.keymap.set(
  {'n', 'v'},
  "<leader>gh",
  function()
    require('gitlinker').get_buf_range_url('n', {action_callback = require('gitlinker.actions').open_in_browser})
  end,
  {desc = "Diff: Open Github in browser to current location in buffer"}
)

vim.keymap.set(
  'n',
  '<leader>dj',
  function()
    require('gitsigns').nav_hunk('next')
  end,
  {desc = 'Diff: Jump to next hunk'}
)

vim.keymap.set(
  'n',
  '<leader>dk',
  function()
    require('gitsigns').nav_hunk('prev')
  end,
  {desc = 'Diff: Jump to previous hunk'}
)

vim.keymap.set(
  {"n", "v"},
  '<leader>dr',
  require('gitsigns').reset_hunk,
  {desc = 'Diff: Reset hunk'}
)

vim.keymap.set(
  'n',
  '<leader>di',
  require('gitsigns').preview_hunk,
  {desc = 'Diff: Inspect hunk'}
)

vim.keymap.set(
  'n',
  '<leader>gg',
  function()
    require('gitsigns').blame_line{full=true}
  end,
  {desc = 'Diff: Toogle line blame ghost text'}
)

vim.keymap.set(
  'n',
  '<leader>dd',
  ':DiffviewOpen<cr>',
  {desc = "Diff: Open diff viewer" }
)

vim.keymap.set(
  'n',
  '<leader>dl',
  require('fzf-lua').git_status,
  { desc = "Diff: List files with uncommitted" }
)

vim.keymap.set(
  'n',
  '<leader>df',
  function()
    require('fzf-lua').git_bcommits({
      actions = {
        -- When a commit is selected, this action will be triggered
        -- 'selected' is a table with information about the commit
        ["default"] = function(selected)
          -- Extract the commit hash from the selected entry
          local commit_hash = selected[1]:match("%w+")
          -- Open diff view between current and selected commit
          if commit_hash then
            require("diffview").open(commit_hash.."^.."..commit_hash)
          else
            print("No commit selected!")
          end
        end,
      },
    })
  end,
  { desc = "Diff: list commits on file" }
)

vim.keymap.set(
  'n',
  '<leader>db',
  function()
    require('fzf-lua').git_branches({
      actions = {
        ["default"] = function(selected)
          local selected_branch = selected[1]:match("[^%s]+")
          if selected_branch then
            -- Open DiffView with the selected branch
            vim.cmd("DiffviewOpen " .. selected_branch)
          else
            vim.notify("No branch selected!", vim.log.levels.WARN)
          end
        end
      }
    })
  end,
  { desc = "Diff: Open branch selector. Diff between selected branch and current is opened in DiffView" }
)

vim.keymap.set(
  "n",
  '<leader>dc',
  function()
    require('fzf-lua').git_commits({
      actions = {
        -- When a commit is selected, this action will be triggered
        -- 'selected' is a table with information about the commit
        ["default"] = function(selected)
          -- Extract the commit hash from the selected entry
          local commit_hash = selected[1]:match("%w+")
          -- Open diff view between current and selected commit
          if commit_hash then
            require("diffview").open(commit_hash.."^.."..commit_hash)
          else
            print("No commit selected!")
          end
        end,
      },
    })
  end,
  { desc = "Diff: Show commits for current repo. Diff between selected commit and current is opened in DiffView" }
)

vim.keymap.set(
  'n',
  '<leader>gb',
  ':Git blame<cr>',
  { desc = "Diff: Git blame" }
)

------------------------------------------------------------------------------------------------------------------------
-- Quickfix
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
  'n',
  '<leader>ko',
  ':copen<CR>',
  {desc = "Quickfix: Open window"}
)

vim.keymap.set(
  'n',
  '<leader>kx',
  ':cclose<CR>',
  {desc = "Quickfix: Close window"}
)

vim.keymap.set(
  'n',
  '<leader>kj',
  ':cnext<CR>',
  {desc = "Quickfix: Next"}
)

vim.keymap.set(
  'n',
  '<leader>kk',
  ':cprev<CR>',
  {desc = "Quickfix: Previous"}
)

vim.keymap.set(
  'n',
  '<leader>kc',
  ':cexpr []<CR>',
  {desc = "Quickfix: Clear"}
)

vim.keymap.set(
  'n',
  '<leader>kf',
  require('fzf-lua').quickfix,
  { desc = "Quickfix: Find quickfix files" }
)

vim.keymap.set(
  'n',
  '<leader>kg',
  require('fzf-lua').grep_quickfix,
  { desc = "Quickfix: Grep" }
)

------------------------------------------------------------------------------------------------------------------------
-- Diagnostic
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
  'n',
  '<leader>ej',
  vim.diagnostic.goto_next,
  {desc = "Diagnostic: go to next"}
)

vim.keymap.set(
  'n',
  '<leader>ek',
  vim.diagnostic.goto_prev,
  {desc = "Diagnostic: go to previous"}
)

vim.keymap.set(
  'n',
  '<leader>ei',
  vim.diagnostic.open_float,
  {desc = 'Diagnostic: inspect'}
)

vim.keymap.set(
  'n',
  '<leader>ef',
  require('fzf-lua').diagnostics_document,
  { desc = "Diagnostic: Show errors" }
)

vim.keymap.set(
  'n',
  '<leader>ep',
  require('fzf-lua').diagnostics_workspace,
  { desc = "Diagnostic: Show errors" }
)

------------------------------------------------------------------------------------------------------------------------
-- Help
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
  'n',
  '<leader>?',
  require('fzf-lua').keymaps,
  { desc = "Help: Show keymaps" }
)

vim.keymap.set(
  'n',
  '<leader>`',
  require("lazy").profile,
  {desc = 'Help: Lazy plugin manager'}
)

vim.keymap.set(
  'n',
  '<leader>~',
  ':Mason<cr>',
  {desc = 'Help Mason package manager'}
)

vim.keymap.set(
  'n',
  '<leader>vk',
  require('fzf-lua').helptags,
  { desc = "Help: vim help" }
)

vim.keymap.set(
  'n',
  '<leader>vr',
  require('fzf-lua').registers,
  { desc = "Help: vim registers" }
)

vim.keymap.set(
  'n',
  '<leader>vh',
  require('fzf-lua').highlights,
  { desc = "Help: vim highlight groups" }
)

------------------------------------------------------------------------------------------------------------------------
-- Tmux
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
  {"n", "v", "i", "x"},
  '<C-h>',
  require('smart-splits').move_cursor_left,
  {desc = "Tmux: move cursor left"}
)

vim.keymap.set(
  {"n", "v", "i", "x"},
  '<C-j>',
  require('smart-splits').move_cursor_down,
  {desc = "Tmux: move cursor down"}
)

vim.keymap.set(
  {"n", "v", "i", "x"},
  '<C-k>',
  require('smart-splits').move_cursor_up,
  {desc = "Tmux: move cursor up"}
)

vim.keymap.set(
  {"n", "v", "i", "x"},
  '<C-l>',
  require('smart-splits').move_cursor_right,
  {desc = "Tmux: move cursor right"}
)

-- These keymaps aren't used directly.
-- Instead Tmux is responsible for resizing splits.
-- These keymaps need to match up with the corresponding keymaps in the tmux.conf.
vim.keymap.set(
  {"n", "v", "x"},
  '<leader>Rh',
  require('smart-splits').resize_left,
  {desc = "Tmux: resize left"}
)

vim.keymap.set(
  {"n", "v", "x"},
  '<leader>Rj',
  require('smart-splits').resize_down,
  {desc = "Tmux: resize down"}
)

vim.keymap.set(
  {"n", "v", "x"},
  '<leader>Rk',
  require('smart-splits').resize_up,
  {desc = "Tmux: resize up"}
)

vim.keymap.set(
  {"n", "v", "x"},
  '<leader>Rl',
  require('smart-splits').resize_right,
  {desc = "Tmux: resize right"}
)

--vim.keymap.set(
--  "n",
--  "<leader>ri",
--  ":VtrOpenRunner<cr>",
--  {desc = "Tmux: Open runner"}
--)
--
--vim.keymap.set(
--  "n",
--  "<leader>ra",
--  ":VtrAttachToPane<cr>",
--  {desc = "Tmux: Attach to pane"}
--)
--
--vim.keymap.set(
--  "x",
--  "<leader>re",
--  ":call VtrSendLinesToRunnerWrapper()<cr>",
--  {desc = "Tmux: Send lines to runner"}
--)
--
--vim.keymap.set(
--  "n",
--  "<leader>rf",
--  ":VtrSendFile<cr>",
--  {desc = "Tmux: Send file to runner"}
--)

------------------------------------------------------------------------------------------------------------------------
-- Debug
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
  'n',
  '<leader>eo',
  "<cmd>lua require'dapui'.toggle()<cr>",
  {desc = 'Debug: Open debug UI'}
)

vim.keymap.set(
  'n',
  '<leader>ee',
  "<cmd>lua require('dapui').eval()<cr>",
  {desc = 'Debug: Evaluate'}
)

vim.keymap.set(
  'n',
  '<leader>ew',
  require('dap').toggle_breakpoint,
  {desc = 'Debug: Set breakpoint'}
)

vim.keymap.set(
  'n',
  '<leader>eq',
  require('dap').clear_breakpoints,
  {desc = 'Debug: Clear breakpoints'}
)

vim.keymap.set(
  'n',
  '<M-i>',
  require('dap').step_into,
  {desc = 'Debug: Step into'}
)

vim.keymap.set(
  'n',
  '<M-o>',
  require('dap').step_over,
  {desc = 'Debug: Step over'}
)

vim.keymap.set(
  'n',
  '<M-p>',
  require('dap').continue,
  {desc = 'Debug: Continue to next breakpoint (Proceed)'}
)

vim.keymap.set(
  'n',
  '<leader>ex',
  require('dap').close,
  {desc = 'Debug: Closes the current debug session'}
)

vim.keymap.set(
  'n',
  '<leader>e ',
  require('dap').run,
  {desc = 'Debug: Runs a new debug session'}
)

------------------------------------------------------------------------------------------------------------------------
-- Database
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
  'n',
  '<leader>sc',
  ':SqlsSwitchConnection<cr>',
  {desc = 'Database: Switch connection'}
)

------------------------------------------------------------------------------------------------------------------------
-- Find
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
  'n',
  '<leader>f ',
  require('fzf-lua').resume,
  { desc = 'Find: resume previous fzf-lua session' }
)

vim.keymap.set(
  'n',
  '<leader>fg',
  require('fzf-lua').live_grep,
  { desc = 'Grep snippets folder' }
)

vim.keymap.set(
  'n',
  '<C-f>',
  require('bufs').buffers,
  { desc = 'Find: open buffers' }
)

vim.keymap.set(
  'n',
  '<leader>vc',
  require('fzf-lua').command_history,
  { desc = 'Vim command history' }
)

vim.keymap.set(
  'n',
  '<leader>sg',
  function()
    require('fzf-lua').live_grep({
      cwd="~/Developer/snippets/",
      prompt="Grep Snippets",
    })
  end,
  { desc = 'Grep snippets folder' }
)

vim.keymap.set(
  'n',
  '<leader>sf',
  function()
    require('fzf-lua').files({
      cwd="~/Developer/snippets/",
      prompt="Find Snippets",
    })
  end,
  { desc = 'Find snippets' }
)

vim.keymap.set(
  'n',
  '<leader>/',
  require('fzf-lua').grep_curbuf,
  { desc = 'Grep current buffer' }
)

vim.keymap.set(
  'n',
  '<leader>fw',
  require('fzf-lua').grep_cword,
  { desc = 'Find: grep for word under cursor' }
)

vim.keymap.set(
  'n',
  '<leader>fo',
  require('fzf-lua').oldfiles,
  { desc = 'Find: last opened files' }
)

vim.keymap.set(
  'n',
  '<C-g>',
  ':b#<cr>',
  { desc = 'Alternate buffer' }
)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(event)
    vim.keymap.set(
      'n',
      '<leader>fd',
      require('fzf-lua').lsp_definitions,
      {desc = 'Find: definition', buffer = event.buf}
    )

    vim.keymap.set(
      'n',
      '<leader>fr',
      require('fzf-lua').lsp_references,
      {desc = 'Find: all references', buffer = event.buf}
    )

    vim.keymap.set(
      'n',
      '<leader>ft',
      require('fzf-lua').lsp_typedefs,
      {desc = 'Find: type definitions', buffer = event.buf}
    )

    vim.keymap.set(
      'n',
      '<leader>fi',
      require('fzf-lua').lsp_implementations,
      {desc = 'Find: implementations', buffer = event.buf}
    )

    vim.keymap.set(
      'n',
      '<leader>fS',
      require('fzf-lua').lsp_document_symbols,
      {desc = 'Find: symbols in current document', buffer = event.buf}
    )

    vim.keymap.set(
      'n',
      '<leader>fW',
      require('fzf-lua').lsp_live_workspace_symbols,
      {desc = 'Find: symbols in entire workspace', buffer = event.buf}
    )

    vim.keymap.set(
      'n',
      '<leader>cr',
      vim.lsp.buf.rename,
      {desc = 'Code: Rename symbol', buffer = event.buf}
    )

    vim.keymap.set(
      {'n', 'v'},
      '<leader>ca',
      vim.lsp.buf.code_action,
      {desc = 'Code: Actions', buffer = event.buf}
    )

    vim.keymap.set(
      'n',
      'K',
      vim.lsp.buf.hover,
      {desc = 'Code: Hover info', buffer = event.buf}
    )

    vim.keymap.set(
      'n',
      '<space>cf',
      function() vim.lsp.buf.format { async = true } end,
      {desc = 'Code: Format', buffer = event.buf})
  end,
})

------------------------------------------------------------------------------------------------------------------------
-- AI
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
  'n',
  "<leader>h",
  require('config.copilot').toggle,
  { desc = "Github Copilot Toggle" }
)

------------------------------------------------------------------------------------------------------------------------
-- Macros
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
  'n',
  '<leader>cn',
  ':s/ *, */\\r/g<cr>',
  {desc = 'Macro: Split comma separated value into new lines'}
)

------------------------------------------------------------------------------------------------------------------------
-- Execute
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
  'n',
  "<leader>:",
  ":.lua<cr>",
  {desc = 'Execute: Execute current line in lua'}
)

vim.keymap.set(
  'v',
  "<leader>:",
  ":lua<cr>",
  {desc = 'Execute: Execute visual select in lua'}
)

vim.keymap.set(
  'n',
  '<leader>;',
  function()
    vim.cmd('source %')
  end,
  {desc = "Execute: Source current file" }
)

vim.keymap.set(
  'n',
  "<leader>fe",
  require('oil').toggle_float,
  {desc = "File management"}
)

-- Set up EasyAlign in visual mode
vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})

-- Set up EasyAlign for a motion/text object in normal mode
vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})

------------------------------------------------------------------------------------------------------------------------
-- Local Plugins
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
  'n',
  '<leader>a',
  require("trail_marker").place_marker,
  { desc = "Trail Marker: Add marker to current trail" }
)

vim.keymap.set(
  'n',
  '<leader>r',
  require("trail_marker").remove_marker,
  { desc = "Trail Marker: Remove marker from current trail" }
)

vim.keymap.set(
  'n',
  '<C-n>',
  require("trail_marker").next_marker,
  { desc = "Trail Marker: Go to next marker" }
)

vim.keymap.set(
  'n',
  '<C-p>',
  require("trail_marker").prev_marker,
  { desc = "Trail Marker: Go to previous marker" }
)

vim.keymap.set(
  'n',
  '<leader>t',
  require("trail_marker").current_marker,
  { desc = "Trail Marker: Go to current marker" }
)

vim.keymap.set(
  'n',
  '<C-t>',
  require("trail_marker.extensions.fzf-lua").trail_map,
  { desc = "Trail Marker: List markers on current trail" }
)

vim.keymap.set(
  'n',
  '<C-s>',
  require("trail_marker.extensions.fzf-lua").change_trail,
  { desc = "TrailMarker: Switch trails" }
)
