local T = {}

function T.setup()

    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<leader>ua', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
    vim.api.nvim_set_keymap('n', '<leader>ud', "<cmd>lua require'dap'.continue()<cr>"         , opts)
    vim.api.nvim_set_keymap('n', '<leader>uu', "<cmd>lua require'dap'.step_into()<cr>"        , opts)
    vim.api.nvim_set_keymap('n', '<leader>uo', "<cmd>lua require'dap'.step_over()<cr>"        , opts)

end

return T
