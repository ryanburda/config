local T = {}

function T.setup()
    local rt = require("rust-tools")

    -- Must install https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb
    local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.9.0/'
    local codelldb_path = extension_path .. 'adapter/codelldb'
    --local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'  -- Linux
    local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'  -- MacOS

    rt.setup({
        server = {
            on_attach = function(_, bufnr)
                -- Hover actions
                vim.keymap.set("n", "<M-m>", rt.hover_actions.hover_actions, { buffer = bufnr })
                -- Code action groups
                vim.keymap.set("n", "<M-,>", rt.code_action_group.code_action_group, { buffer = bufnr })
            end,
        },
        dap = {
            adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
        },
    })
end

return T





