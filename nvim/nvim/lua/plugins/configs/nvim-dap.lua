local T = {}

function T.setup()

    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<A-h>', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
    vim.api.nvim_set_keymap('n', '<A-j>', "<cmd>lua require'dap'.step_into()<cr>"        , opts)
    vim.api.nvim_set_keymap('n', '<A-k>', "<cmd>lua require'dap'.step_over()<cr>"        , opts)
    vim.api.nvim_set_keymap('n', '<A-l>', "<cmd>lua require'dap'.continue()<cr>"         , opts)  -- This also starts a dap session.
    vim.api.nvim_set_keymap('n', '<A-x>', "<cmd>lua require'dap'.clear_breakpoints()<cr>", opts)

    local dap = require('dap')

    -- C, C++, Rust
    dap.adapters.codelldb = require('dap.adapters.codelldb').adapter
    dap.configurations.c = require('dap.configurations.c').launch_configuration
    dap.configurations.cpp = require('dap.configurations.c').launch_configuration
    dap.configurations.rust = require('dap.configurations.c').launch_configuration

end

return T
