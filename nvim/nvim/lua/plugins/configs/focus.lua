local T = {}

function T.setup()

    require("focus").setup({
        enable = false,
        width = 120,
        hybridnumber = false,
        signcolumn = false,
        quickfixheight = 20,
        compatible_filetrees = {"nvimtree", "FileTree", "nerdtree", "chadtree", "fern", },
        treewidth = require("plugins.configs.nvim-tree").TREE_WIDTH,
        excluded_filetypes = {
            "toggleterm",
            "DiffviewFiles",
            "Outline",
            "dapui_console",
            "dap-repl",
            "dapui_stacks",
            "dapui_scopes",
            "dapui_watches",
        },
        excluded_buftypes = {
            "nofile",
            "prompt",
            "popup",
            "help",
        },
    })

    local opts = { noremap=true, silent=false}
    vim.api.nvim_set_keymap("n", "<leader>'", ":FocusEnable<cr>" , opts)
    vim.api.nvim_set_keymap("n", "<leader>;", ":FocusDisable<cr>", opts)


end

return T



