local T = {}

local mason_registry = require('mason-registry')
local status, codelldb = pcall(mason_registry.get_package, 'codelldb')

-- Install codelldb via Mason if it is not installed already.
if status == false then
    vim.cmd('MasonInstall codelldb')
    codelldb = mason_registry.get_package('codelldb')
end

T.adapter = {
    type = 'server',
    port = "${port}",
    executable = {
        command = codelldb:get_install_path() .. '/extension/adapter/codelldb',
        args = {"--port", "${port}", },
    }
}

return T
