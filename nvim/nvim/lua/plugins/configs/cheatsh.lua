local T = {}

function T.setup()

    local opts = { noremap=true, silent=false }
    vim.api.nvim_set_keymap('n', '<leader>?', ':Cheat<CR>', opts)

end

return T
