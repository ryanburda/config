local opts = { noremap=true, silent=false }

vim.api.nvim_set_keymap('n', '<leader>gg', ':Git<cr>'          , opts)
vim.api.nvim_set_keymap('n', '<leader>ga', ':Git add .<cr>'    , opts)
vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit<cr>'   , opts)
vim.api.nvim_set_keymap('n', '<leader>g ', ':Git pull<cr>'     , opts)
vim.api.nvim_set_keymap('n', '<leader>gp', ':Git push<cr>'     , opts)
vim.api.nvim_set_keymap('n', '<leader>gb', ':Git blame<cr>'    , opts)
vim.api.nvim_set_keymap('n', '<leader>gm', ':Git mergetool<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>gh', ':diffget //2<cr>'  , opts)  -- take diff left
vim.api.nvim_set_keymap('n', '<leader>gl', ':diffget //3<cr>'  , opts)  -- take diff right
