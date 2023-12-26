local T = {}

function T.setup()

    require('bufferline').setup({
        options = {
            close_command = "Bdelete",
            show_close_icon = false,
            show_buffer_close_icons = true,
            offsets = {
                {
                    filetype = "neo-tree",
                    highlight = "Directory",
                    separator = true -- use a "true" to enable the default, or set your own character
                },
            },
            hover = {
                enabled = true,
                delay = 10,
                reveal = {'close'}
            },
            separator_style = "thin",
        }
    })

    vim.keymap.set('n', '<leader>i', ':BufferLineCyclePrev<cr>', {desc = 'Cycle through buffers left. (Mnemonic: overlaps with jumplist navigation <C-i>)'})
    vim.keymap.set('n', '<leader>o', ':BufferLineCycleNext<cr>', {desc = 'Cycle through buffers right. (Mnemonic: overlaps with jumplist navigation <C-o>)'})
    vim.keymap.set('n', '<leader>I', ':BufferLineMovePrev<cr>' , {desc = 'Move current buffer to the left in the bufferline'})
    vim.keymap.set('n', '<leader>O', ':BufferLineMoveNext<cr>' , {desc = 'Move current buffer to the right in the bufferline'})

end

return T
