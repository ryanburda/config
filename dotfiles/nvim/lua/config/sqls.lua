local T = {}

function T.setup()
    vim.api.nvim_create_autocmd('User', {
        pattern = 'SqlsConnectionChoice',
        callback = function(event)
            vim.g.sqls_connection = T.clean_connection_string(event.data.choice)
        end
    })
end

function T.get_all_connections()
    -- Keep connection information outside of version control by grabbing this infomation from files like .pgpass
    local conns = {}

    -- Postgres
    for _, c in ipairs(T.get_postgres_connections(os.getenv("HOME") .. "/.pgpass")) do
        table.insert(conns, c)
    end
    -- TODO: add other types of connections.

    return conns
end

function T.get_postgres_connections(file_path)
    -- Parse a .pgpass file and return connection tables that sqls expects.
    local connections = {}

    -- Open the .pgpass file
    local file = io.open(file_path, "r")
    if not file then
        return connections
    end

    -- Read each line from the file
    for line in file:lines() do
        -- Skip empty lines and comments
        if line:match("^#") or line:match("^%s*$") then
            goto continue
        end

        -- Split the line by colon (:)
        local host, port, db, user, pass = line:match("([^:]+):([^:]+):([^:]+):([^:]+):([^:]+)")

        if host and port and db and user and pass then
            -- Construct the dataSourceName string
            local dataSourceName = string.format(
                "host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
                host, port, user, pass, db
            )

            -- Insert the connection table into the connections list
            table.insert(connections, {
                driver = "postgresql",
                dataSourceName = dataSourceName,
            })
        end

        ::continue::
    end

    -- Close the file
    file:close()
    return connections
end

function T.clean_connection_string(connection_string)
    -- Takes the connection string returned from SqlsConnectionChoice event and removes sensitive information.
    --
    -- Assumes string will be of the form
    -- "<#> <db_type>  host=<host_name> port=<port_number> user=<user> password=<password> dbname=<db_name> sslmode=disable"
    -- For example:
    -- "1 postgresql  host=localhost port=5432 user=postgres password=postgres dbname=postgres sslmode=disable"
    --
    -- NOTE: This likely needs to be updated to support databases other than Postgres.

    -- Capture the second word in the connection string which indicates the database type
    local db_type = connection_string:match("^%s*%S+%s+(%S+)")
    -- Pattern to capture host, port, user, and dbname
    local host = connection_string:match("host=([^%s]+)")
    local port = connection_string:match("port=([^%s]+)")
    local user = connection_string:match("user=([^%s]+)")
    local dbname = connection_string:match("dbname=([^%s]+)")

    return string.format("%s %s:%s/%s user=%s", db_type, host, port, dbname, user)
end

return T
