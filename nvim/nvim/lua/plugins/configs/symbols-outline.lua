local T = {}

function T.setup()

    require("symbols-outline").setup({
        relative_width = false,
        width = 40,
    })

    local opts = { noremap=true, silent=false}
    vim.api.nvim_set_keymap('n', '<leader>ss', ":SymbolsOutlineOpen<cr>", opts)
    vim.api.nvim_set_keymap('n', '<leader>sx', ":SymbolsOutlineClose<cr>", opts)

end

return T
