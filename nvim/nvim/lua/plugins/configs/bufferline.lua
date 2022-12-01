local T = {}

function T.setup()

    require('bufferline').setup({
        options = {
            close_command = "Bdelete",
            show_close_icon = false,
            show_buffer_close_icons = true,
            offsets = {
                {
                    filetype = "NvimTree",
                    highlight = "Directory",
                    separator = true -- use a "true" to enable the default, or set your own character
                },
                {
                    filetype = "Outline",
                    highlight = "Directory",
                    separator = true -- use a "true" to enable the default, or set your own character
                }
            },
            hover = {
                enabled = true,
                delay = 10,
                reveal = {'close'}
            },
            separator_style = "thick",
        }
    })

    local opts = { noremap=true, silent=false }
    vim.api.nvim_set_keymap('n', '<leader>i', ':BufferLineCyclePrev<cr>', opts)
    vim.api.nvim_set_keymap('n', '<leader>o', ':BufferLineCycleNext<cr>', opts)
    vim.api.nvim_set_keymap('n', '<leader>I', ':BufferLineMovePrev<cr>' , opts)
    vim.api.nvim_set_keymap('n', '<leader>O', ':BufferLineMoveNext<cr>' , opts)

end

return T
