local T = {}

function T.setup()
    -- mappings
    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<leader>at', ':NvimTreeFocus<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>ax', ':NvimTreeClose<CR>', opts)

    -- setup
    require('nvim-tree').setup({
        update_cwd = false,
        hijack_cursor = true,
        update_focused_file = {
            enable = true,
            update_cwd = true,
        }
    })
end

return T
