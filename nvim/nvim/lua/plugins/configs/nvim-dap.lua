local T = {}

function T.setup()

    local opts = { noremap=true, silent=true }
    -- NOTE: Set System Preferences -> Keyboard -> Input Sources -> Unicode Hex Input to allow Alt key remaps.
    vim.api.nvim_set_keymap('n', '<M-;>', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
    vim.api.nvim_set_keymap('n', '<M-j>', "<cmd>lua require'dap'.step_into()<cr>"        , opts)
    vim.api.nvim_set_keymap('n', '<M-k>', "<cmd>lua require'dap'.step_over()<cr>"        , opts)
    vim.api.nvim_set_keymap('n', '<M-l>', "<cmd>lua require'dap'.continue()<cr>"         , opts)
    vim.api.nvim_set_keymap('n', '<M-0>', "<cmd>lua require'dap'.clear_breakpoints()<cr>", opts)

    local dap = require('dap')

    -- C, C++, Rust
    dap.adapters.codelldb = require('dap.adapters.codelldb').adapter
    dap.configurations.c = require('dap.configurations.c').launch_configuration
    dap.configurations.cpp = require('dap.configurations.c').launch_configuration
    dap.configurations.rust = require('dap.configurations.c').launch_configuration

end

return T
