local T = {}

function T.setup()

    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup({
        expand_lines = true,
        layouts = {
            {
                elements = {
                    { id = "watches", size = 0.25 },
                    { id = "stacks", size = 0.25 },
                    { id = "console", size = 0.25 },
                    { id = "repl", size = 0.25 },
                },
                size = 65, -- # of columns
                position = "right",
            },
            {
                elements = {
                    { id = "scopes", size = 1.0 },
                },
                size = 12, -- # of rows
                position = "bottom",
            },
        },
    })

    dap.listeners.after.event_initialized['dapui_config'] = function () dapui.open() end
    -- Close the dap-ui automatically after tests end or fail.
    -- dap.listeners.before.event_terminated['dapui_config'] = function () dapui.close() end
    -- dap.listeners.before.event_exited['dapui_config'] = function () dapui.close() end

    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<M-v>', "<cmd>lua require'dapui'.toggle()<cr>", opts)
    vim.api.nvim_set_keymap('n', '<M-e>', "<cmd>lua require('dapui').eval()<cr>", opts)

end

return T
