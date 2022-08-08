local T = {}
T.default = require('lsp.server_default')
T.config = T.default.config

function T.on_attach(client, bufnr)
    T.default.on_attach(client, bufnr)
    require('debug.adapters.codelldb')
end

T.config = {}
T.config.on_attach = T.on_attach

return T

