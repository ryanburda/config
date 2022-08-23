local T = {}

function T.setup()

    require("symbols-outline").setup({
        relative_width = false,
        width = 40,
    })

    local opts = { noremap=true, silent=false}
    vim.api.nvim_set_keymap('n', '<leader>ss', ":SymbolsOutlineOpen<cr>", opts)
    vim.api.nvim_set_keymap('n', '<leader>sx', ":SymbolsOutlineClose<cr>", opts)

    -- Make the background darker.
    -- local augroup = vim.api.nvim_create_augroup("SymbolsOutline", { clear = true })
    -- vim.api.nvim_create_autocmd("FileType", { pattern = "Outline", command = "highlight! link NormalNC Pmenu", group = augroup })

end

return T
