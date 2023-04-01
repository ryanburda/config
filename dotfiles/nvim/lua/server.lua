-- This module is responsible for starting a server so that other processes can interact with Neovim programmatically.
--
-- In it's most basic case it merely provides a wrapper around the existing server start and stop commands while:
--   * keeping track of the pipe name
--   * only allowing a single server to spawn per neovim instance
--
-- When combined with tmux it manages a tmux environment variable that can be referenced by other shells in the same
-- session so that there is always a single server where commands are sent. Other tools or scripts can then rely on
-- this variable to script up solutions to common workflows.

local T = {}
T.NVIM_PIPE_VAR = "NVIM_PIPE"

T.get_pipe = function ()
    -- Return the pipe of the server.
    return T.pipe
end

T.getenv = function(var)
    -- wrapper around `vim.fn.getenv` to ensure `nil` is returned in certain situations.
    local v = vim.fn.getenv(var)

    if v == '' then
        return nil
    elseif v == vim.NIL then
        return nil
    else
        return v
    end
end

T.tmux_getenv = function(var)
    -- tmux equivalent of `getenv` wrapper above.
    local handle = io.popen("tmux show-environment " .. var .. " | awk -F '=' '{print $2}'")
    local v = handle:read('*l')
    handle:close()

    if v == '' then
        return nil
    elseif v == vim.NIL then
        return nil
    else
        return v
    end
end

T.start = function()
    -- Start a neovim server if one is not already running and return the pipe.
    if T.pipe == nil then
        math.randomseed(os.clock()^5)

        T.pipe = '/tmp/nvim_' .. math.random(1,10000000) .. '.pipe'
        vim.fn.serverstart(T.pipe)

        print("Server initialized: " .. T.pipe)
    else
        print("Server already initialized: " .. T.pipe)
    end

    return T.pipe
end

T.tmux_start = function()
    -- Only allow 1 nvim server to be associated with the NVIM_PIPE environment variable per tmux session. The
    -- NVIM_PIPE variable acts as a poor person's semaphore which is more than good enough for this use case.
    if T.getenv("TMUX") ~= nil and T.tmux_getenv(T.NVIM_PIPE_VAR) == nil then
        io.popen("tmux setenv " .. T.NVIM_PIPE_VAR .. " " .. T.start())
    end
end

T.stop = function()
    -- Stop the nvim server.
    if T.getenv("TMUX") ~= nil and T.get_pipe() == T.tmux_getenv(T.NVIM_PIPE_VAR) then
        io.popen("tmux setenv -r " .. T.NVIM_PIPE_VAR)
    end

    vim.fn.serverstop(T.pipe)
    T.pipe = nil
end

T.setup = function()
    -- Let autocommands handle the setup and teardown of the server.
    local augroup = vim.api.nvim_create_augroup("server_rpc", { clear = true })
    vim.api.nvim_create_autocmd("VimEnter", { callback = T.tmux_start, group = augroup })
    vim.api.nvim_create_autocmd("VimLeave", { callback = T.stop, group = augroup })

    -- Create vim wrappers around lua functions.
    vim.api.nvim_create_user_command("ServerStart", T.start, {})
    vim.api.nvim_create_user_command("ServerTmuxStart", T.tmux_start, {})
    vim.api.nvim_create_user_command("ServerStop", T.stop, {})
    vim.api.nvim_create_user_command("ServerPipe", function() print(T.get_pipe()) end, {})
end

return T
