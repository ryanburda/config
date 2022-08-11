local T = {}

function T.setup()
    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup({
        layouts = {
            {
                elements = {
                    { id = "scopes", size = 0.25 },
                    "breakpoints",
                    "stacks",
                    "watches",
                },
                size = 40, -- 40 columns
                position = "right",
            },
            {
                elements = {
                    "repl",
                    "console",
                },
                size = 0.25, -- 25% of total lines
                position = "bottom",
            },
        },
    })

    dap.listeners.after.event_initialized['dapui_config'] = function () dapui.open() end
    dap.listeners.before.event_terminated['dapui_config'] = function () dapui.close() end
    dap.listeners.before.event_exited['dapui_config'] = function () dapui.close() end

    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<M-o>', "<cmd>lua require'dapui'.open()<cr>"  , opts)
    vim.api.nvim_set_keymap('n', '<M-x>', "<cmd>lua require'dapui'.close()<cr>" , opts)
    vim.api.nvim_set_keymap('n', '<M-h>', "<cmd>lua require('dapui').eval()<cr>", opts)


end

return T
