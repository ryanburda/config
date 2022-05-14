local T = {}

T.setup = function()
    vim.g.tmux_navigator_no_mappings = 1

    -- navigation is handled by <C-hjkl> no matter if it is a tmux pane or a vim split.
    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<C-h>', ':TmuxNavigateLeft<cr>'    , opts)
    vim.api.nvim_set_keymap('n', '<C-j>', ':TmuxNavigateDown<cr>'    , opts)
    vim.api.nvim_set_keymap('n', '<C-k>', ':TmuxNavigateUp<cr>'      , opts)
    vim.api.nvim_set_keymap('n', '<C-l>', ':TmuxNavigateRight<cr>'   , opts)
    vim.api.nvim_set_keymap('n', '<C-;>', ':TmuxNavigatePrevious<cr>', opts)
end

return T
