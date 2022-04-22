vim.g.VtrStripLeadingWhitespace = 0
vim.g.VtrClearEmptyLines = 0
vim.g.VtrAppendNewline = 1

local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap('n', '<leader>ei', ':VtrOpenRunner<cr>'       , opts)
vim.api.nvim_set_keymap('n', '<leader>ea', ':VtrAttachToPane<cr>'     , opts)
vim.api.nvim_set_keymap('x', '<leader>ee', ':VtrSendLinesToRunner<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>ef', ':VtrSendFile<cr>'         , opts)
