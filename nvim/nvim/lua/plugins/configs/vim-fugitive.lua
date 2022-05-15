local T = {}

T.setup = function()
    local opts = { noremap=true, silent=false }

    vim.api.nvim_set_keymap('n', '<leader>gg', ':Git<cr>'                         , opts)
    vim.api.nvim_set_keymap('n', '<leader>ga', ':Git add .<cr>'                   , opts)
    vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit<cr>'                  , opts)
    vim.api.nvim_set_keymap('n', '<leader>g ', ':Git pull<cr>'                    , opts)
    vim.api.nvim_set_keymap('n', '<leader>gp', ':Git push<cr>'                    , opts)
    vim.api.nvim_set_keymap('n', '<leader>gb', ':Git blame<cr>'                   , opts)
    vim.api.nvim_set_keymap('n', '<leader>gm', ':Git mergetool<cr>'               , opts)
    vim.api.nvim_set_keymap('n', '<leader>dD', ':Git difftool<cr>'                , opts)  -- add diff files to quickfix list
    vim.api.nvim_set_keymap('n', '<leader>dO', ':Git difftool --name-only origin/', opts)  -- add diff files to quickfix list
    vim.api.nvim_set_keymap('n', '<leader>dh', ':diffget //2<cr>'                 , opts)  -- take diff left
    vim.api.nvim_set_keymap('n', '<leader>dl', ':diffget //3<cr>'                 , opts)  -- take diff right
end

return T
