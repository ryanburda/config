local T = {}

function T.setup()

    local opts = { noremap=true, silent=false}
    vim.api.nvim_set_keymap('n', '<leader>ss', ":SymbolsOutlineOpen<cr>", opts)
    vim.api.nvim_set_keymap('n', '<leader>sx', ":SymbolsOutlineClose<cr>", opts)

    vim.g.symbols_outline = {
        auto_preview = false,
        width = 15,
        keymaps = { -- These keymaps can be a string or a table for multiple keys
            close = {},
            goto_location = "<Cr>",
            focus_location = "o",
            hover_symbol = "<C-space>",
            toggle_preview = "K",
            rename_symbol = "r",
            code_actions = "a",
        }
    }

end

return T
