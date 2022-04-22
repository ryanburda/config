-- mappings
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>cs', '<cmd>lua require("chtsh").func()<cr>', opts)
