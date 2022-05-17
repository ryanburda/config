local T = {}

T.setup = function()
    local opts = { noremap=true, silent=false }

    vim.api.nvim_set_keymap('n', '<leader>db', ':Git blame<cr>'                   , opts)
    vim.api.nvim_set_keymap('n', '<leader>dD', ':Git difftool<cr>'                , opts)  -- add diff files to quickfix list
    vim.api.nvim_set_keymap('n', '<leader>dO', ':Git difftool --name-only origin/', opts)  -- add diff files to quickfix list

    vim.api.nvim_set_keymap('n', '<leader>dm', ':Git mergetool<cr>'               , opts)  -- add conflicted files to quickfix list
    vim.api.nvim_set_keymap('n', '<leader>dv', ':Gvdiffsplit!<cr>'                , opts)  -- 3 way visual split
    vim.api.nvim_set_keymap('n', '<leader>dh', ':diffget //2<cr>'                 , opts)  -- take diff left
    vim.api.nvim_set_keymap('n', '<leader>dl', ':diffget //3<cr>'                 , opts)  -- take diff right
end

return T
