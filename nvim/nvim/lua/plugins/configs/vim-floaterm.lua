local T = {}

function T.setup()

    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<leader>tt', ':FloatermNew<CR>', opts)

end

return T
