local lsp_installer = require('nvim-lsp-installer')

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
--
-- Individual server config files are stored in `lsp/servers/<<server_name>>.lua`. The default config will be used if a
-- lua file does not exist for the lsp server being setup.
lsp_installer.on_server_ready(function(server)
    local status, config = pcall(require, 'lsp.configs.' .. server.name)

    if status == false then
        config = require('lsp.server_default')
    end

    -- This setup() function will take the provided server configuration and decorate it with the necessary properties
    -- before passing it onwards to lspconfig.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(config)
end)
