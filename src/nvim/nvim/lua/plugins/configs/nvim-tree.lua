-- setup
require('nvim-tree').setup({
    update_cwd = false,
    hijack_cursor = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    }
})

-- mappings
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>aa', ':NvimTreeFocus<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ah', ':NvimTreeClose<CR>', opts)
