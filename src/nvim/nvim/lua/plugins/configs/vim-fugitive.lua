-- mappings
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>gs', ':Git<cr>'          , opts)
vim.api.nvim_set_keymap('n', '<leader>gd', ':Git diff<cr>'     , opts)
vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit<cr>'   , opts)
vim.api.nvim_set_keymap('n', '<leader>gp', ':Git push<cr>'     , opts)
vim.api.nvim_set_keymap('n', '<leader>gb', ':Git blame<cr>'    , opts)
vim.api.nvim_set_keymap('n', '<leader>gd', ':Git difftool<cr>' , opts)
vim.api.nvim_set_keymap('n', '<leader>gm', ':Git mergetool<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>gf', ':diffget //2<cr>'  , opts)  -- take diff left
vim.api.nvim_set_keymap('n', '<leader>gj', ':diffget //3<cr>'  , opts)  -- take diff right
