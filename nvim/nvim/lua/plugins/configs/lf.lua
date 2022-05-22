local T = {}

function T.setup()
    local opts = { noremap=true, silent=false }
    vim.api.nvim_set_keymap('n', '<leader>aa', ':Lf<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>aw', ':LfWorkingDirectory<CR>', opts)
end

return T
