-- mappings
-- NOTE: the extra 'v`<' at the end of the visual commands is used to exit visual mode and return to the top off
-- the visual block.
vim.api.nvim_set_keymap(
    "n",
    "<leader>gg",
    "<cmd>lua require('gitlinker').get_buf_range_url('n')<cr>",
    { noremap=true, silent=true }
)
vim.api.nvim_set_keymap(
    "v",
    "<leader>gg",
    "<cmd>lua require('gitlinker').get_buf_range_url('v')<cr>v`<",
    { noremap=true, silent=false }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>gh",
    "<cmd>lua require('gitlinker').get_buf_range_url('n', {action_callback = require('gitlinker.actions').open_in_browser})<cr>",
    { noremap=true, silent=true }
)
vim.api.nvim_set_keymap(
    "v",
    "<leader>gh",
    "<cmd>lua require('gitlinker').get_buf_range_url('v', {action_callback = require('gitlinker.actions').open_in_browser})<cr>v`<",
    { noremap=true, silent=false }
)
