-- This script is based on the following shell command:
-- ```sh
-- awk '!/^#|^$/' ~/.pgpass | while IFS=: read -r host port db user pass; do
--   echo "Host: $host"
--   echo "Port: $port"
--   echo "Database: $db"
--   echo "User: $user"
--   echo "Password: $pass"
--   echo "----------"
-- done
-- ```
--
-- This will read the pgpass file and return a lua table that is a set of connections
-- ```
-- {
--     {
--         driver = 'postgresql',
--         dataSourceName = 'host=127.0.0.1 port=5432 user=postgres password=mysecretpassword1234 dbname=dvdrental sslmode=disable',
--     },
--     {
--         driver = 'postgresql',
--         dataSourceName = 'host=127.0.0.1 port=5433 user=postgres password=mysecretpassword2345 dbname=dvdrental sslmode=disable',
--     },
-- }
-- ```
--
-- Lua function to parse the ~/.pgpass file and return a table with connections

local T = {}

function T.parse_pgpass(file_path)
    local connections = {}

    -- Open the .pgpass file
    local file = io.open(file_path, "r")
    if not file then
        print("Error: Could not open file " .. file_path)
        return connections
    end

    -- Read each line from the file
    for line in file:lines() do
        -- Skip empty lines and lines that start with #
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

return T
