local T = {}

function T.setup()

    vim.g.cheat_default_window_layout = 'split'

    local opts = { noremap=true, silent=false }
    vim.api.nvim_set_keymap('n', '<leader>?', ':Cheat<CR>', opts)

end

return T
