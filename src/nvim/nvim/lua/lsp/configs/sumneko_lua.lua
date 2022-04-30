-- Returns a config for the sqls language server.
local config = require('lsp.server_default')

config.settings = {
    Lua = {
        runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
        },
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'require', 'vim' },
        },
    },
}

return config
