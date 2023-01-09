local T = {}

local mason_registry = require("mason-registry")
local codelldb = mason_registry.get_package("codelldb")

T.adapter = {
    type = 'server',
    port = "${port}",
    executable = {
        command = codelldb:get_install_path() .. '/extension/adapter/codelldb',
        args = {"--port", "${port}", },
    }
}

return T
