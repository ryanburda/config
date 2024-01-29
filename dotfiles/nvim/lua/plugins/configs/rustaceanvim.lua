local T = {}

function T.setup()
    local cfg = require('rustaceanvim.config')
    local mason_registry = require("mason-registry")
    local operating_system = vim.uv.os_uname().sysname;

    -- This will fail if codelldb isn't installed through Mason.
    local codelldb = mason_registry.get_package("codelldb")
    local extension_path = codelldb:get_install_path() .. "/extension/"
    local codelldb_path = extension_path .. 'adapter/codelldb'
    local liblldb_path = 'lldb/lib/liblldb' .. (operating_system == "Linux" and ".so" or ".dylib")

    vim.g.rustaceanvim = {
        server = {
            on_attach = function(_, bufnr)
                --vim.keymap.set("n", "<M-m>", rt.hover_actions.hover_actions, { buffer = bufnr })
                --vim.keymap.set("n", "<M-,>", rt.code_action_group.code_action_group, { buffer = bufnr })
                vim.keymap.set("n", "<M-d>", vim.cmd.RustLsp('debuggables'), { buffer = bufnr })
            end,
        },
        dap = {
            adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path)
        },
    }
end
