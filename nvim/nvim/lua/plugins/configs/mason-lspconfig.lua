local T = {}

function T.setup()
    local servers = {
        "bashls",
        "clangd",
        "dockerls",
        "jdtls",
        "jsonls",
        "pyright",
        "rust_analyzer",
        "sumneko_lua",
        "sqls",
        "yamlls"
    }

    local lspconfig = require("lspconfig")

    for _, server in ipairs(servers) do
        local config
        local status, s = pcall(require, "lsp/servers/" .. server)

        if status == true then
            config = s.config
        else
            config = require("lsp.server_default").config
        end

        lspconfig[server].setup(config)
    end

    require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_installation = true,
    })

end

return T
