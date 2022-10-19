local T = {}

function T.setup()

    require("peek").setup()

    vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
    vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})

    local opts = { noremap=true, silent=false}
    vim.api.nvim_set_keymap('n', '<leader>mo', ':PeekOpen<cr>', opts)
    vim.api.nvim_set_keymap('n', '<leader>mx', ':PeekClose<cr>', opts)

end

return T
