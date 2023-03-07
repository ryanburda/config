local T = {}

T.setup = function ()
    vim.keymap.set('n', '<M-g>', ':Git blame<cr>', {desc = "Git Blame in separate split"})
end

return T
