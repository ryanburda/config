local T = {}

function T.setup()

    require("peek").setup()

    local opts = { noremap=true, silent=false}
    vim.api.nvim_set_keymap("n", "<leader>mo", "<cmd> lua require('peek').open()<cr>", opts)
    vim.api.nvim_set_keymap("n", "<leader>mx", "<cmd> lua require('peek').close()<cr>", opts)

end

return T
