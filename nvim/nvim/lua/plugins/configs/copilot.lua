local T = {}

function T.setup()

    local sysname = vim.loop.os_uname().sysname

    if sysname == "Darwin" then
        local handle = assert(io.popen("brew list node@16 | grep 'node$'"))
        local node16_executable_path = handle:read("*l")
        handle:close()

        vim.g.copilot_node_command = node16_executable_path
    end

    require('copilot').setup()

end

return T


