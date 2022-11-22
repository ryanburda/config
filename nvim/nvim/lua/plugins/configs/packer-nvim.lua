local T = {}

function T.setup()

    local opts = { noremap=true, silent=false }
    vim.api.nvim_set_keymap('n', '<leader>pc', ':lua require("packer").compile()<cr>', opts)
    vim.api.nvim_set_keymap('n', '<leader>pu', ':lua require("packer").update()<cr>', opts)
    vim.api.nvim_set_keymap('n', '<leader>ps', ':lua require("packer").sync()<cr>', opts)

end

return T
