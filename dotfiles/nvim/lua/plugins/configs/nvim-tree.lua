local T = {}

T.TREE_WIDTH = 36

function T.setup()

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
        view = {
            width = 36,
        },
        actions = {
            remove_file = {
                close_window = false,
            },
        },
    })

    vim.keymap.set('n', '<M-a>', ':NvimTreeToggle<cr>', {desc = "File Tree Toggle"})

end

return T
