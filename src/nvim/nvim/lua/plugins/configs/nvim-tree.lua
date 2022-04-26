require('nvim-tree').setup()

local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap('n', '<leader>aa', ':NvimTreeFocus<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ah', ':NvimTreeClose<CR>', opts)
