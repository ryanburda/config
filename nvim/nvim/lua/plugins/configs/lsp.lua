local T = {}

function T.setup()
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

    require("nvim-lsp-installer").setup {
        ensure_installed = servers,
        automatic_installation = true,
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
end

return T
