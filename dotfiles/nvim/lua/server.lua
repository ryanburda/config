-- This module is responsible for starting a server so that other processes can interact with Neovim programmatically.
--
-- In it's most basic case it merely provides a wrapper around the existing server start and stop commands while:
--   * keeping track of the pipe name
--   * only allowing a single server to spawn per neovim instance
--
-- When combined with tmux it allows an environment variable to be shared between shells in the same session so that
-- there is always a single server where commands are sent. Other tools or scripts can then rely on this variable
-- to script up solutions to common workflows.
--
-- The following code needs to be added to `~/.zshrc` in order for the environment variable to be managed correctly.
-- ```
-- # Automatically update the NVIM_PIPE env var in all panes of a tmux session if it is changed.
-- # NOTE: Comment this block out and `source ~/.zshrc` if this behavior needs to be temporarily turned off.
-- autoload -U add-zsh-hook
-- update_nvim_pipe() {
--     local var
--     var=$(tmux show-environment | grep '^NVIM_PIPE=')
--     if [ "$?" -eq 0 ]; then
--         eval "$var"
--     else
--         unset NVIM_PIPE
--     fi
-- }
-- if [[ -n "$TMUX" ]]; then
--     add-zsh-hook preexec update_nvim_pipe
-- fi
-- ```

local T = {}

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
    -- Only allow 1 nvim server to be associated with the NVIM_PIPE environment variable per session. The
    -- NVIM_PIPE variable acts as a poor person's semaphore which is more than good enough for this use case.
    if vim.fn.getenv("NVIM_PIPE") == vim.NIL then
        local pipe = T.start()

        -- Set the NVIM_PIPE env var for the current shell.
        vim.fn.setenv("NVIM_PIPE", pipe)
        -- Set the NVIM_PIPE env var in tmux so new shells obtain the correct value automatically.
        -- This value is also kept up to date using a `preexec` zsh hook in `~/.zshrc`. This ensures
        -- that existing tmux panes in the same session do not end up holding on to a stale value.
        io.popen("tmux setenv NVIM_PIPE '".. pipe .. "'")
    end
end

T.stop = function()
    -- Stop the nvim server.
    if T.pipe == vim.fn.getenv("NVIM_PIPE") then
        vim.fn.serverstop(T.pipe)
        io.popen("tmux setenv -r NVIM_PIPE")
        io.popen("unset NVIM_PIPE")
        T.pipe = nil
    else
        vim.fn.serverstop(T.pipe)
    end
end

T.get_pipe = function ()
    -- Return the pipe of the server.
    return T.pipe
end

T.setup = function()
    -- Let autocommands handle the setup and teardown of the server.
    local augroup = vim.api.nvim_create_augroup("server_rpc", { clear = true })
    vim.api.nvim_create_autocmd("VimEnter", { callback = T.tmux_start, group = augroup })
    vim.api.nvim_create_autocmd("VimLeave", { callback = T.stop, group = augroup })

    -- Create vim wrappers around lua functions.
    vim.api.nvim_create_user_command("ServerStart", T.start, {})
    vim.api.nvim_create_user_command("ServerStop", T.stop, {})
    vim.api.nvim_create_user_command("ServerPipe", function() print(T.get_pipe()) end, {})
end

return T
