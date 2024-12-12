-- Keymaps in this file are grouped by purpose, not plugin.
--
-- For example, keymaps associated with diffs/version control currently use the following plugins:
--      * telescope
--      * diffview
--      * gitsigns
-- and are all prefixed with '<leader>d*':
--      * '<leader>dr' - diff reset hunk. (gitsigns)
--      * '<leader>dd' - open diffview. (diffview)
--      * '<leader>db' - opens a branch picker in telescope, upon selection diffview is opened
--                       showing diff between current code and selected branch. (telescope + diffview)
--
-- This last example is important because declaring a keymap with two plugin dependencies outside the setup
-- functions of either plugin eliminates the need for plugin dependencies that exist solely for keymap creation.

------------------------------------------------------------------------------------------------------------------------
-- Window Management
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
    'n',
    '<leader>t',
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

vim.keymap.set(
    'n',
    '<leader>q',
    ':Bdelete<cr>',
    {desc = 'Window Management: Delete buffer without changing window layout'}
)

vim.keymap.set(
    'n',
    '<leader>Q',
    ':Bdelete!<cr>',
    {desc = 'Window Management: Force delete buffer without changing window layout'}
)

vim.keymap.set(
    'n',
    '<leader>i',
    ':BufferLineCyclePrev<cr>',
    {desc = 'Window Management: Cycle through buffers left. (Mnemonic: overlaps with jumplist navigation <C-i>)'}
)

vim.keymap.set(
    'n',
    '<leader>o',
    ':BufferLineCycleNext<cr>',
    {desc = 'Window Management: Cycle through buffers right. (Mnemonic: overlaps with jumplist navigation <C-o>)'}
)

vim.keymap.set(
    'n',
    '<leader>I',
    ':BufferLineMovePrev<cr>',
    {desc = 'Window Management: Move current buffer to the left in the bufferline'}
)

vim.keymap.set(
    'n',
    '<leader>O',
    ':BufferLineMoveNext<cr>',
    {desc = 'Window Management: Move current buffer to the right in the bufferline'}
)

vim.keymap.set(
    'n',
    "<leader>a",
    ":Neotree toggle<CR>",
    {desc = "Window Management: Toogle file tree"}
)

------------------------------------------------------------------------------------------------------------------------
-- Navigation
------------------------------------------------------------------------------------------------------------------------
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
    { 'n', 'v', 'x' },
    '<C-u>',
    function() require('neoscroll').ctrl_u({ duration = 100 }) end,
    { desc = "Navigation: Up half page" }
)

vim.keymap.set(
    { 'n', 'v', 'x' },
    '<C-d>',
    function() require('neoscroll').ctrl_d({ duration = 100 }) end,
    { desc = "Navigation: Down half page" }
)

vim.keymap.set(
    { 'n', 'v', 'x' },
    '<C-y>',
    function() require('neoscroll').scroll(-0.1, { move_cursor=false; duration = 100 }) end,
    { desc = "Navigation: Show more on top" }
)

vim.keymap.set(
    { 'n', 'v', 'x' },
    '<C-e>',
    function() require('neoscroll').scroll(0.1, { move_cursor=false; duration = 100 }) end,
    { desc = "Navigation: Show more on bottom" }
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
    '<leader>F',
    ":let @+=expand('%')<CR>",
    {desc = 'Clipboard: Copy relative file path to clipboard'}
)

vim.keymap.set(
    'n',
    '<leader>A',
    ":let @+=expand('%:p')<CR>",
    {desc = 'Clipboard: Copy absolute file path to clipboard'}
)

vim.keymap.set(
    'n',
    '<leader>D',
    ":let @+=expand('%:h')<CR>",
    {desc = 'Clipboard: Copy directory path to clipboard'}
)

------------------------------------------------------------------------------------------------------------------------
-- Browser
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
    'n',
    '<leader>m',
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
    '<C-n>',
    function()
        require('gitsigns').nav_hunk('next')
    end,
    {desc = 'Diff: Jump to next hunk'}
)

vim.keymap.set(
    'n',
    '<C-p>',
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
    '<leader>dh',
    ':DiffviewFileHistory<cr>',
    {desc = "Diff: Full repo commit history in diff viewer"}
)

vim.keymap.set(
    'n',
    '<leader>dl',
    require('telescope.builtin').git_status,
    { desc = "Diff: List files with uncommitted changes in Telescope" }
)

vim.keymap.set(
    'n',
    '<leader>db',
    require('telescope.builtin').git_branches,
    { desc = "Diff: Open branch selector in Telescope. Diff between selected branch and current is opened in DiffView" }
)

vim.keymap.set(
    "n",
    '<leader>df',
    require('telescope').extensions.advanced_git_search.diff_commit_file,
    { desc = "Diff: Show commits for current file in Telescope. Diff between selected commit and current is opened in DiffView" }
)

vim.keymap.set(
    "n",
    '<leader>dc',
    require('telescope').extensions.advanced_git_search.search_log_content,
    { desc = "Diff: Show commits for current repo in Telescope. Diff between selected commit and current is opened in DiffView" }
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
    require('telescope.builtin').quickfix,
    { desc = "Quickfix: Find files" }
)

vim.keymap.set(
    'n',
    '<leader>kg',
    function()
        require('telescope.builtin').live_grep({
            search_dirs = require('config.telescope').getqflist_files(),
            results_title = 'Quickfix Files'
        })
    end,
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
    require('telescope.builtin').diagnostics,
    { desc = "Diagnostic: Show errors in Telescope" }
)

------------------------------------------------------------------------------------------------------------------------
-- Help
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
    'n',
    '<leader>?',
    require('telescope.builtin').keymaps,
    { desc = "Help: Show keymaps in Telescope" }
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
    require('telescope.builtin').help_tags,
    { desc = "Help: vim help pages in Telescope" }
)

vim.keymap.set(
    'n',
    '<leader>vr',
    require('telescope.builtin').registers,
    { desc = "Help: vim registers" }
)

vim.keymap.set(
    'n',
    '<leader>vh',
    require('telescope.builtin').highlights,
    { desc = "Help: vim highlight groups" }
)

vim.keymap.set(
    'n',
    '<leader>mk',
    require('telescope.builtin').man_pages,
    { desc = "Help: man pages in Telescope" }
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

vim.keymap.set(
    "n",
    "<leader>ri",
    ":VtrOpenRunner<cr>",
    {desc = "Tmux: Open runner"}
)

vim.keymap.set(
    "n",
    "<leader>ra",
    ":VtrAttachToPane<cr>",
    {desc = "Tmux: Attach to pane"}
)

vim.keymap.set(
    "x",
    "<leader>re",
    ":call VtrSendLinesToRunnerWrapper()<cr>",
    {desc = "Tmux: Send lines to runner"}
)

vim.keymap.set(
    "n",
    "<leader>rf",
    ":VtrSendFile<cr>",
    {desc = "Tmux: Send file to runner"}
)

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
    require('telescope.builtin').resume,
    { desc = 'Find: resume previous Telescope session' }
)

vim.keymap.set(
    'n',
    '<leader>ff',
    require('telescope.builtin').find_files,
    { desc = 'Find: find files in Telescope' }
)

vim.keymap.set(
    'n',
    '<leader>fg',
    require('multigrep').grep_glob,
    { desc = 'Find: grep with optional glob filter following double space' }
)

vim.keymap.set(
    'n',
    '<leader>f/',
    function() require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown{ winblend = 10, previewer = false, }) end,
    { desc = 'Find: current buffer fuzzy find in Telescope' }
)

vim.keymap.set(
    'n',
    '<leader>fj',
    require('telescope.builtin').grep_string,
    { desc = 'Find: grep for word under cursor in Telescope' }
)

vim.keymap.set(
    'n',
    '<leader>fl',
    require('telescope.builtin').oldfiles,
    { desc = 'Find: last opened files' }
)

vim.keymap.set(
    'n',
    '<leader>fb',
    require('telescope.builtin').buffers,
    { desc = 'Find: open buffers' }
)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
    callback = function(event)
        vim.keymap.set(
            'n',
            '<leader>fd',
            require('telescope.builtin').lsp_definitions,
            {desc = 'Find: definition', buffer = event.buf}
        )

        vim.keymap.set(
            'n',
            '<leader>fa',
            require('telescope.builtin').lsp_references,
            {desc = 'Find: all references', buffer = event.buf}
        )

        vim.keymap.set(
            'n',
            '<leader>fi',
            require('telescope.builtin').lsp_implementations,
            {desc = 'Find: implementations', buffer = event.buf}
        )

        vim.keymap.set(
            'n',
            '<leader>fs',
            require('telescope.builtin').lsp_document_symbols,
            {desc = 'Find: symbols in current document', buffer = event.buf}
        )

        vim.keymap.set(
            'n',
            '<leader>fw',
            require('telescope.builtin').lsp_dynamic_workspace_symbols,
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
-- Other
------------------------------------------------------------------------------------------------------------------------
vim.keymap.set(
    'n',
    "<leader>:",
    ":.lua<cr>",
    {desc = 'Other: Execute current line in lua'}
)

vim.keymap.set(
    'v',
    "<leader>:",
    ":lua<cr>",
    {desc = 'Other: Execute visual select in lua'}
)

vim.keymap.set(
    'n',
    '<leader>;',
    function()
        vim.cmd('source %')
    end,
    {desc = "Other: Source current file" }
)
