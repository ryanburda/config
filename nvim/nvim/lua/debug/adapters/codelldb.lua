local dap = require('dap')

local mason_registry = require("mason-registry")
local codelldb = mason_registry.get_package("codelldb")

dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        command = codelldb:get_install_path() .. '/extension/adapter/codelldb',
        args = {"--port", "${port}", },
    }
}

dap.configurations.rust = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {"run", },
    },
}

