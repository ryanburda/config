local T = {}

T.setup = function()
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
        local status, r = pcall(require, "lsp/servers/" .. server)

        if status == true then
            config = r.config
        else
            config = require("lsp.server_default").config
        end

        lspconfig[server].setup(config)
    end
end

return T
