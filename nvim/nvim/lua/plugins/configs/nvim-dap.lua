local T = {}

local dap = require('dap')
local dapui = require('dapui')

dap.listeners.after.event_initialized['dapui_config'] = function ()
    dapui.open()
end

dap.listeners.before.event_terminated['dapui_config'] = function ()
    dapui.close()
end

dap.listeners.before.event_exited['dapui_config'] = function ()
    dapui.close()
end

function T.setup()

    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<leader>uu', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
    vim.api.nvim_set_keymap('n', '<leader>uU', "<cmd>lua require'dap'.clear_breakpoints()<cr>", opts)
    vim.api.nvim_set_keymap('n', '<leader>ud', "<cmd>lua require'dap'.continue()<cr>"         , opts)
    vim.api.nvim_set_keymap('n', '<leader>ui', "<cmd>lua require'dap'.step_into()<cr>"        , opts)
    vim.api.nvim_set_keymap('n', '<leader>uo', "<cmd>lua require'dap'.step_over()<cr>"        , opts)

    -- dapui
    vim.api.nvim_set_keymap('n', '<leader>ua', "<cmd>lua require'dapui'.open()<cr>" , opts)
    vim.api.nvim_set_keymap('n', '<leader>ux', "<cmd>lua require'dapui'.close()<cr>", opts)

end

return T
