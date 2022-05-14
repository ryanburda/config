local T = {}

T.setup = function()
    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<leader>?', '<cmd>lua require("chtsh").func()<cr>', opts)
end

return T
