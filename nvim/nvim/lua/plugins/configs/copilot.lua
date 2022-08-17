local T = {}

T.STATUS_VAR = 'is_copilot_on'


function T.get_state()
    -- Gets the state of copilot that is stored in a global variable.
    return vim.g[T.STATUS_VAR]
end

function T.enable()
    -- Turns on copilot and writes the state to a global variable.
    if pcall(function() require('copilot').setup() end) then
        vim.g[T.STATUS_VAR] = true
    else
        vim.g[T.STATUS_VAR] = false
    end
end

function T.disable()
    -- Turns off copilot and writes the state to a global variable.
    if pcall(function() vim.cmd('CopilotStop') end) then
        vim.g[T.STATUS_VAR] = false
    else
        vim.g[T.STATUS_VAR] = true
    end
end

function T.toggle()
    -- Toggles the state of copilot.
    if T.get_state() then
        T.disable()
    else
        T.enable()
    end

    return T.get_state()
end


function T.setup()
    -- Plugin config function.
    local sysname = vim.loop.os_uname().sysname

    if sysname == "Darwin" then
        local handle = assert(io.popen("brew list node@16 | grep 'node$'"))
        local node16_executable_path = handle:read("*l")
        handle:close()

        vim.g.copilot_node_command = node16_executable_path
    end

    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<leader>ai', ':lua print("Copilot on: " .. tostring(require("plugins.configs.copilot").toggle()))<cr>', opts)

end

return T
