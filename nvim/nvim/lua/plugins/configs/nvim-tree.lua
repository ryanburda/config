local T = {}

function T.setup()

    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<leader>at', ':NvimTreeFocus<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>ax', ':NvimTreeClose<CR>', opts)

    vim.cmd("let g:nvim_tree_show_icons = {'git': 0, 'folders': 1, 'files': 1, 'folder_arrows': 1 }")

    require('nvim-tree').setup({
        update_cwd = false,
        hijack_cursor = true,
        update_focused_file = {
            enable = true,
            update_cwd = true,
        },
    })

end

return T
