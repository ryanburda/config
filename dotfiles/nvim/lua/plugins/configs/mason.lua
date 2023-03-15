local T = {}

function T.setup()
    require("mason").setup()

    local opts = { noremap=true, silent=false}
    vim.api.nvim_set_keymap('n', '<leader>~', ':Mason<cr>', opts)
end

return T
