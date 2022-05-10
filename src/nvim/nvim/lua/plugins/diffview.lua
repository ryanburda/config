local opts = { noremap=true, silent=false }

vim.api.nvim_set_keymap('n', '<leader>dd', ':DiffviewOpen<cr>'                , opts)
vim.api.nvim_set_keymap('n', '<leader>do', ':DiffviewOpen origin/'            , opts)
vim.api.nvim_set_keymap('n', '<leader>df', ':DiffviewFileHistory<cr>'         , opts)
vim.api.nvim_set_keymap('n', '<leader>da', ':DiffviewFileHistory .<cr>'       , opts)
vim.api.nvim_set_keymap('n', '<leader>dx', ':DiffviewClose<cr>'               , opts)
vim.api.nvim_set_keymap('n', '<leader>dr', ':DiffviewRefresh<cr>'             , opts)
vim.api.nvim_set_keymap('n', '<leader>dt', ':DiffviewToggleFiles<cr>'         , opts)


