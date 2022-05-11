local lsp = {}

function lsp.setup()
    require("nvim-lsp-installer").setup {
        ensure_installed = {
            "awk_ls",
            "bashls",
            "clangd",
            "dockerls",
            "jdtls",
            "jsonls",
            "pyright",
            "sumneko_lua",
            "sqls",
            "yamlls"
        },
        automatic_installation = true,
    }
    local lspconfig = require("lspconfig")
    local server_default = require("lsp.server_default")

    lspconfig.clangd.setup(server_default)

    lspconfig.dockerls.setup(server_default)

    lspconfig.jdtls.setup(server_default)

    lspconfig.jsonls.setup(server_default)

    lspconfig.pyright.setup(server_default)

    lspconfig.sumneko_lua.setup(require("lsp.configs.sumneko_lua"))

    lspconfig.sqls.setup(require("lsp.configs.sqls"))

    lspconfig.yamlls.setup(require("lsp.configs.yamlls"))
end

return lsp
