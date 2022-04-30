-- Returns a config for the sqls language server.
local config = require('lsp.server_default')
local default_on_attach = config.on_attach

local BUF_VAR_KEY_HOST = 'sqls_conn_host'
local BUF_VAR_KEY_DB   = 'sqls_conn_db'
local BUF_VAR_KEY_PORT = 'sqls_conn_port'
local BUF_VAR_KEY_USER = 'sqls_conn_user'
local BUF_VAR_KEY_LSP_EXTRA = 'lsp_extra'


local conn_string_to_tbl = function(str)
    -- converts the connection string returned from a sqls.nvim 'connection_choice' event into a table.
    -- NOTE: the connection string changes based on what was passed to dataSourceName when the sqls connection
    --       was created. This function is only guaranteed to work with connections that were created with the
    --       `get_pgpass_connections` funciton below since the order of the keys here matches that function.
    local values = {}
    for value in string.gmatch(str, '%S+') do
        table.insert(values, value)
    end

    local order = { 'number', 'driver', 'host', 'port', 'db', 'user', 'password' }
    local tbl = {}

    for i = 1, #order do
        tbl[order[i]] = values[i]
    end

    return tbl
end

local set_lsp_extra = function()
    -- Reads the sqls specific buffer variables and sets the `lsp_extra` buffer variable.
    -- NOTE: Should be called after any of the `sqls` buffer variables are updated.
    local host = vim.api.nvim_buf_get_var(0, BUF_VAR_KEY_HOST) or ''
    local db = vim.api.nvim_buf_get_var(0, BUF_VAR_KEY_DB) or ''
    local port = vim.api.nvim_buf_get_var(0, BUF_VAR_KEY_PORT) or ''
    local user = vim.api.nvim_buf_get_var(0, BUF_VAR_KEY_USER) or ''

    local str = host .. ' ' .. db .. ' ' .. port .. ' ' .. user

    vim.api.nvim_buf_set_var(0, BUF_VAR_KEY_LSP_EXTRA, str)
end

local function get_pgpass_connections(pgpass_path)
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

local on_attach = function(client, bufnr)
    default_on_attach(client, bufnr)

    require('sqls').on_attach(client, bufnr)

    require('sqls.events').add_subscriber('connection_choice', function(event)
        local tbl = conn_string_to_tbl(event.choice)
        vim.api.nvim_buf_set_var(0, BUF_VAR_KEY_HOST, tbl['host'])
        vim.api.nvim_buf_set_var(0, BUF_VAR_KEY_DB, tbl['db'])
        vim.api.nvim_buf_set_var(0, BUF_VAR_KEY_PORT, tbl['port'])
        vim.api.nvim_buf_set_var(0, BUF_VAR_KEY_USER, tbl['user'])
        set_lsp_extra()
    end)

    require('sqls.events').add_subscriber('database_choice', function(event)
        vim.api.nvim_buf_set_var(0, BUF_VAR_KEY_DB, 'dbname=' .. event.choice)
        set_lsp_extra()
    end)

    -- Switch the connection to force a 'connection_choice' event which sets the lsp_extra buffer variable.
    require('sqls.commands').switch_connection(1)

    local opts = { noremap=true, silent=false }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>s ', ":SqlsExecuteQuery<cr>"    , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>s ', ":SqlsExecuteQuery<cr>"    , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sc', ":SqlsSwitchConnection<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sd', ":SqlsSwitchDatabase<cr>"  , opts)

end


-- return the config
config.on_attach = on_attach
config.settings = {
    sqls = {
        connections = get_pgpass_connections()
    },
}

return config
