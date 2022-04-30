local opts = { noremap=true, silent=false }

vim.api.nvim_set_keymap('n', '<leader>dd', ':DiffviewOpen<cr>'                , opts)
vim.api.nvim_set_keymap('n', '<leader>dD', ':Git difftool<cr>'                , opts)  -- add diff files to quickfix list
vim.api.nvim_set_keymap('n', '<leader>do', ':DiffviewOpen origin/'            , opts)
vim.api.nvim_set_keymap('n', '<leader>dO', ':Git difftool --name-only origin/', opts)  -- add diff files to quickfix list
vim.api.nvim_set_keymap('n', '<leader>df', ':DiffviewFileHistory<cr>'         , opts)
vim.api.nvim_set_keymap('n', '<leader>da', ':DiffviewFileHistory .<cr>'       , opts)
vim.api.nvim_set_keymap('n', '<leader>dx', ':DiffviewClose<cr>'               , opts)
vim.api.nvim_set_keymap('n', '<leader>dr', ':DiffviewRefresh<cr>'             , opts)
vim.api.nvim_set_keymap('n', '<leader>dt', ':DiffviewToggleFiles<cr>'         , opts)


