-- Returns a config for the sqls language server.
local opts = { noremap=true, silent=false }

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>s ', ":SqlsExecuteQuery<cr>"    , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>s ', ":SqlsExecuteQuery<cr>"    , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sc', ":SqlsSwitchConnection<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sd', ":SqlsSwitchDatabase<cr>"  , opts)

    require("lsp.server_default").on_attach(client, bufnr)
    require('sqls').on_attach(client, bufnr)
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

local config = {
    on_attach = on_attach,
    settings = {
        sqls = {
            connections = get_psql_connections()
        },
    }
}

return config
