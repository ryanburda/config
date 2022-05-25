local T = {}

function T.setup()

    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<leader>aa', ':NvimTreeFocus<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>ax', ':NvimTreeClose<CR>', opts)

    vim.cmd("let g:nvim_tree_show_icons = {'git': 0, 'folders': 1, 'files': 1, 'folder_arrows': 0 }")
    vim.cmd("let g:nvim_tree_autoclose = 1")

    require('nvim-tree').setup({
        hijack_unnamed_buffer_when_opening = true,
        update_cwd = false,
        hijack_cursor = true,
        update_focused_file = {
            enable = true,
            update_cwd = true,
        },
        renderer = {
            indent_markers = {
                enable = true,
                icons = {
                    corner = "└ ",
                    edge = "│ ",
                    none = "  ",
                },
            },
        },
    })

end

return T
