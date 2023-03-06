local T = {}

function T.setup()

    -- NOTE: Set System Preferences -> Keyboard -> Input Sources -> Unicode Hex Input to allow Alt key remaps.
    vim.keymap.set('n', '<M-b>', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", {desc = "Debug: Set breakpoint"})
    vim.keymap.set('n', '<M-0>', "<cmd>lua require'dap'.clear_breakpoints()<cr>", {desc = "Debug: Clear breakpoints"})
    vim.keymap.set('n', '<M-i>', "<cmd>lua require'dap'.step_into()<cr>"        , {desc = "Debug: Step into"})
    vim.keymap.set('n', '<M-o>', "<cmd>lua require'dap'.step_over()<cr>"        , {desc = "Debug: Step over"})
    vim.keymap.set('n', '<M-p>', "<cmd>lua require'dap'.continue()<cr>"         , {desc = "Debug: Continue to next breakpoint (Proceed)"})

    local dap = require('dap')

    -- C, C++, Rust
    dap.adapters.codelldb = require('dap.adapters.codelldb').adapter
    dap.configurations.c = require('dap.configurations.c').launch_configuration
    dap.configurations.cpp = require('dap.configurations.c').launch_configuration
    dap.configurations.rust = require('dap.configurations.c').launch_configuration

end

return T
