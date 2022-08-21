local T = {}

function T.setup()

    require("symbols-outline").setup({
        width = 20
    })

    local opts = { noremap=true, silent=false}
    vim.api.nvim_set_keymap('n', '<leader>ss', ":SymbolsOutline<cr>", opts)

end

return T
