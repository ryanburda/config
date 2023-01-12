local T = {}

function T.setup()

    local servers = {
        "bashls",
        "dockerls",
        "jsonls",
        "pyright",
        "rust_analyzer",
        "sumneko_lua",
        "sqlls",
        "yamlls"
    }

    require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_installation = true,
    })

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

end

return T
