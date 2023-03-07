local T = {}

T.TREE_WIDTH = 36

function T.setup()

    vim.keymap.set('n', '<M-s>', ":SymbolsOutline<CR>", {desc = "Symbols Outline Toggle", })

    require("symbols-outline").setup({
        width = 20,
        autofold_depth = 1,
    })

end

return T
