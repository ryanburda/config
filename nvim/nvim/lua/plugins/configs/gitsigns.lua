local T = {}

function T.setup()

    local on_attach = function(bufnr)
        local opts = { noremap=true, silent=false }
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gj', ':Gitsigns next_hunk<CR>'                , opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gk', ':Gitsigns prev_hunk<CR>'                , opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gp', ':Gitsigns preview_hunk<CR>'             , opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', ':Gitsigns reset_hunk<CR>'               , opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>gr', ':Gitsigns reset_hunk<CR>'               , opts)
    end

    local config = {
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d>: <abbrev_sha> - <summary>',
        on_attach = on_attach,
    }


    require('gitsigns').setup(config)

end

return T
