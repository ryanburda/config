local T = {}

function T.setup()
    local opts = { noremap=true, silent=false }
    vim.api.nvim_set_keymap('n', '<leader>gg', ':LazyGit<CR>', opts)
end

return T
