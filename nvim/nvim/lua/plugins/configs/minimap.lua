local T = {}

function T.setup()
    vim.cmd('let g:minimap_width = 10')
    vim.cmd('let g:minimap_auto_start = 1')
    vim.cmd('let g:minimap_auto_start_win_enter = 1')

    local opts = { noremap=true, silent=false }
    vim.api.nvim_set_keymap('n', '<leader>mm', ':Minimap<CR>'     , opts)
    vim.api.nvim_set_keymap('n', '<leader>mx', ':MinimapClose<CR>', opts)
end

return T


