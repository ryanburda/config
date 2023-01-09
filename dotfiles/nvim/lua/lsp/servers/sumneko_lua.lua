local T = {}
T.default = require('lsp.server_default')

require("neodev").setup()

-- Setup the config
T.config = T.default.config
T.config.settings = {
    Lua = {
        completion = {
            callSnippet = "Replace",
        },
        runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
        },
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'require', 'vim', },
            telemetry = {
                enable = false
            },
        },
    },
}

return T
