local T = {}

function T.setup()
    -- mappings
    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap("n", "<leader>ji", ":BrowserSearch<cr>"     , opts)
    vim.api.nvim_set_keymap("v", "<leader>ji", ":'<,'>BrowserSearch<cr>", opts)
end

return T
