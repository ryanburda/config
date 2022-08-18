local T = {}

function T.setup()

    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup({
        expand_lines = vim.fn.has("nvim-0.7"),
        layouts = {
            {
                elements = {
                    { id = "watches", size = 0.10 },
                    { id = "breakpoints", size = 0.10 },
                    { id = "scopes", size = 0.10 },
                    { id = "stacks", size = 0.20 },
                    { id = "repl", size = 0.20 },
                    { id = "console", size = 0.30 },
                },
                size = 75, -- # of columns
                position = "right",
            },
        },
    })

    dap.listeners.after.event_initialized['dapui_config'] = function () dapui.open() end
    -- Close the dap-ui automatically after tests end or fail.
    -- dap.listeners.before.event_terminated['dapui_config'] = function () dapui.close() end
    -- dap.listeners.before.event_exited['dapui_config'] = function () dapui.close() end

    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<M-o>', "<cmd>lua require'dapui'.toggle()<cr>", opts)
    vim.api.nvim_set_keymap('n', '<M-x>', "<cmd>lua require'dapui'.close()<cr>" , opts)
    vim.api.nvim_set_keymap('n', '<M-h>', "<cmd>lua require('dapui').eval()<cr>", opts)

end

return T
