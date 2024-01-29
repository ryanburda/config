local T = {}

function T.setup()

    local on_attach = function(bufnr)
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n'       , '<C-n>'     , ':Gitsigns next_hunk<CR>'                , opts)
        vim.keymap.set('n'       , '<C-p>'     , ':Gitsigns prev_hunk<CR>'                , opts)
        vim.keymap.set('n'       , '<leader>di', ':Gitsigns preview_hunk<CR>'             , opts)  -- `di` for diff inspect
        vim.keymap.set('n'       , '<M-g>'     , ':Gitsigns toggle_current_line_blame<CR>', opts)
        vim.keymap.set({"n", "v"}, '<leader>dr', ':Gitsigns reset_hunk<CR>'               , opts)
    end

    local config = {
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d>: <abbrev_sha> - <summary>',
        on_attach = on_attach,
    }

    require('gitsigns').setup(config)

end

return T
