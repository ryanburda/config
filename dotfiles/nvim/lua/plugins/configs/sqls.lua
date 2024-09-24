local T = {}

function T.shorten_connection_string(connection_string)
    -- HACK: This needs to be updated to handle connections to databases other than Postgres
    -- Assumes string will be of the form
    -- "<#> <db_type>  host=<host_name> port=<port_number> user=<user> password=<password> dbname=<db_name> sslmode=disable"
    -- For example:
    -- "2 postgresql  host=localhost port=5433 user=postgres password=postgres dbname=finance_datamart sslmode=disable"

    -- Capture the second word in the connection string which indicates the database type
    local db_type = connection_string:match("^%s*%S+%s+(%S+)")
    -- Pattern to capture host, port, user, and dbname
    local host = connection_string:match("host=([^%s]+)")
    local port = connection_string:match("port=([^%s]+)")
    local user = connection_string:match("user=([^%s]+)")
    local dbname = connection_string:match("dbname=([^%s]+)")

    return string.format("%s %s:%s/%s user=%s", db_type, host, port, dbname, user)
end

function T.setup()
    vim.api.nvim_create_autocmd('User', {
        pattern = 'SqlsConnectionChoice',
        callback = function(event)
            vim.g.sqls_connection = T.shorten_connection_string(event.data.choice)
        end
    })
end

return T
