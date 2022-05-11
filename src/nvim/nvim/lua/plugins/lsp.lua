local lsp = {}

local servers = {
    "bashls",
    "clangd",
    "dockerls",
    "jdtls",
    "jsonls",
    "pyright",
    "sumneko_lua",
    "sqls",
    "yamlls"
}

function lsp.setup()
    require("nvim-lsp-installer").setup {
        ensure_installed = servers,
        automatic_installation = true,
    }
    local lspconfig = require("lspconfig")

    for _, server in ipairs(servers) do
        local status, config = pcall(require, 'lsp/servers/' .. server)

        if status == false then
            config = require('lsp.server_default')
        end

        lspconfig[server].setup(config)
    end
end

return lsp
