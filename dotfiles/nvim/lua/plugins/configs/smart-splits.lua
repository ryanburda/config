local T = {}

function T.setup()
    require('smart-splits').setup({default_amount = 1})
    vim.keymap.set({"n", "v", "i", "x"}, '<C-h>', require('smart-splits').move_cursor_left)
    vim.keymap.set({"n", "v", "i", "x"}, '<C-j>', require('smart-splits').move_cursor_down)
    vim.keymap.set({"n", "v", "i", "x"}, '<C-k>', require('smart-splits').move_cursor_up)
    vim.keymap.set({"n", "v", "i", "x"}, '<C-l>', require('smart-splits').move_cursor_right)
    vim.keymap.set({"n", "v", "i", "x"}, '<M-h>', require('smart-splits').resize_left)
    vim.keymap.set({"n", "v", "i", "x"}, '<M-j>', require('smart-splits').resize_down)
    vim.keymap.set({"n", "v", "i", "x"}, '<M-k>', require('smart-splits').resize_up)
    vim.keymap.set({"n", "v", "i", "x"}, '<M-l>', require('smart-splits').resize_right)
end

return T
