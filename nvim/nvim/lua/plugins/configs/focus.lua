local T = {}

function T.setup()

    require("focus").setup({
        width = 120,
        hybridnumber = false,
        signcolumn = false,
        quickfixheight = 20,
        treewidth = require('plugins.configs.nvim-tree').TREE_WIDTH,
        compatible_filetrees = {"NvimTree"},
        excluded_filetypes = { "toggleterm", "DiffviewFiles", "Outline", },
        excluded_buftypes = { "nofile", "prompt", "popup", "help", "DiffviewFiles", }
    })

end

return T



