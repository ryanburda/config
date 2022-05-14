local T = {}

T.setup = function()
    -- mappings
    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap("n", "<leader>i", ":BrowserSearch<cr>"     , opts)
    vim.api.nvim_set_keymap("v", "<leader>i", ":'<,'>BrowserSearch<cr>", opts)
end

return T
