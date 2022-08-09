local T = {}

function T.setup()

    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<leader>uu', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
    vim.api.nvim_set_keymap('n', '<leader>uU', "<cmd>lua require'dap'.clear_breakpoints()<cr>", opts)
    vim.api.nvim_set_keymap('n', '<leader>ud', "<cmd>lua require'dap'.continue()<cr>"         , opts)  -- This also starts a dap session.
    vim.api.nvim_set_keymap('n', '<leader>ui', "<cmd>lua require'dap'.step_into()<cr>"        , opts)
    vim.api.nvim_set_keymap('n', '<leader>uo', "<cmd>lua require'dap'.step_over()<cr>"        , opts)

    local dap = require('dap')

    -- C, C++, Rust
    dap.adapters.codelldb = require('dap.adapters.codelldb').adapter
    dap.configurations.c = require('dap.configurations.c').launch_file_configuration
    dap.configurations.cpp = require('dap.configurations.c').launch_file_configuration
    dap.configurations.rust = require('dap.configurations.c').launch_file_configuration

end

return T
