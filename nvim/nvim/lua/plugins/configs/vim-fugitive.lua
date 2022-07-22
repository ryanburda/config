local T = {}

function T.setup()

    local opts = { noremap=true, silent=false }

    -- Convention: Uppercase mappings add to quickfix list.
    vim.api.nvim_set_keymap('n', '<leader>DD', ':Git difftool<cr>'    , opts)  -- add diff files to quickfix list
    vim.api.nvim_set_keymap('n', '<leader>DO', ':Git difftool origin/', opts)
    vim.api.nvim_set_keymap('n', '<leader>DL', ':Git difftool '       , opts)

    vim.api.nvim_set_keymap('n', '<leader>DM', ':Git mergetool<cr>', opts)  -- add conflicted files to quickfix list
    vim.api.nvim_set_keymap('n', '<leader>dv', ':Gvdiffsplit!<cr>' , opts)  -- 3 way visual split
    vim.api.nvim_set_keymap('n', '<leader>d,', ':diffget //2<cr>'  , opts)  -- take diff left
    vim.api.nvim_set_keymap('n', '<leader>d.', ':diffget //3<cr>'  , opts)  -- take diff right

end

return T
