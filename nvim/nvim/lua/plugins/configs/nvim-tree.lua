local T = {}

function T.setup()

    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<leader>aa', ':NvimTreeToggle<CR>', opts)

    require('nvim-tree').setup({
        hijack_unnamed_buffer_when_opening = true,
        update_cwd = false,
        hijack_cursor = true,
        update_focused_file = {
            enable = true,
            update_cwd = false,
        },
        renderer = {
            icons = {
                show = {
                    git = false,
                    folder = true,
                    file = true,
                    folder_arrow = false,
                }
            },
            indent_markers = {
                enable = true,
            },
        },
    })

end

return T
