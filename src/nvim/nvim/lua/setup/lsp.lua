local lsp_installer = require("nvim-lsp-installer")

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader><space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader><space>i', '<cmd>lua vim.diagnostic.goto_prev()<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader><space>o', '<cmd>lua vim.diagnostic.goto_next()<CR>' , opts)
vim.api.nvim_set_keymap('n', '<leader><space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>j', '<cmd>lua vim.lsp.buf.definition()<CR>'    , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>'         , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-k>'    , '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end

-- TODO: clean this up so there is only one on_attach function
local on_attach_sqls = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>j', '<cmd>lua vim.lsp.buf.definition()<CR>'    , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>'         , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-k>'    , '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

    require('sqls').on_attach(client, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>s ', ":SqlsExecuteQuery<cr>"    , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>s ', ":SqlsExecuteQuery<cr>"    , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sc', ":SqlsSwitchConnection<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sd', ":SqlsSwitchDatabase<cr>"  , opts)
end

local function get_psql_connections(pgpass_path)
    -- Reads in a pgpass file and returns a connections table that the sqls language server expects.
    --
    -- The output of this function works for nvim-lspconfig.
    -- Other configurations are listed here:
    --     https://github.com/lighttiger2505/sqls#workspace-configuration-sample
    --
    -- Postgres' pgpass file contains a set of rows each representing a separate connection to a Postgres database.
    -- Each row in the pgpass file has the following format:
    --     ```text
    --     host:port:dbname:user:password
    --     ```

    -- default arg since it's usually here.
    if pgpass_path == nil then
        pgpass_path = os.getenv("HOME") .. "/.pgpass"
    end

    local connections = {}

    -- Return an empty connections list if the file does not exist.
    -- This prevents warnings when starting vim on a system where you haven't set up your pgpass file yet.
    local file = io.open(pgpass_path, "r")
    if file == nil then
        return connections
    end

    -- Process each line in the file.
    for line in io.lines(pgpass_path)
    do
        -- skip over blank lines and comments
        if line ~= "" and (string.sub(line, 1, 1) ~= "#") then
            local values = {}

            for value in string.gmatch(line, "([^"..":".."]+)") do
                table.insert(values, value)
            end

            local connection = {
                driver = 'postgresql',
                dataSourceName = string.format("host=%s port=%s dbname=%s user=%s password=%s sslmode=disable", unpack(values)),
            }

            table.insert(connections, connection)
        end
    end

    return connections
end

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
    }

    -- (optional) Customize the options passed to the server
    if server.name == "sqls" then
        opts.on_attach = on_attach_sqls

        opts.settings = {
            sqls = {
                connections = get_psql_connections()
            },
        }
    end

    -- This setup() function will take the provided server configuration and decorate it with the necessary properties
    -- before passing it onwards to lspconfig.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
