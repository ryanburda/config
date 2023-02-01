local T = {}

function T.setup()

    vim.keymap.set('n', '<leader>q', ':Bdelete<cr>', {desc = 'Delete buffer without changing window layout'})
    vim.keymap.set('n', '<leader>Q', ':Bdelete!<cr>' , {desc = 'Force delete buffer without changing window layout'})

end

return T
