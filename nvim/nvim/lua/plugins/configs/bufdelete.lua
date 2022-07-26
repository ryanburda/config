local T = {}

function T.setup()

    local opts = { noremap=true, silent=false}
    vim.api.nvim_set_keymap('n', '<leader>q', ':Bdelete<cr>', opts)

end

return T
