local T = {}

T.STATUS_VAR = 'is_copilot_on'


function T.get_state()
    -- Gets the state of copilot that is stored in a global variable.
    return vim.g[T.STATUS_VAR]
end

function T.enable()
    -- Turns on copilot and writes the state to a global variable.
    if pcall(T.setup) then
        vim.g[T.STATUS_VAR] = true
    else
        vim.g[T.STATUS_VAR] = false
    end
end

function T.disable()
    -- Turns off copilot and writes the state to a global variable.
    if pcall(function() vim.cmd('Copilot disable') end) then
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
    vim.cmd('Lazy load copilot.lua')

    require('copilot').setup()

end

return T
