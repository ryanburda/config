-- Returns a config for the sqls language server.
local on_attach = function(client, bufnr)
    require('lsp.server_default').on_attach(client, bufnr)
end

local config = {
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
        },
    }
}

return config
