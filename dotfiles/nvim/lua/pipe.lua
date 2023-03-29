local T = {}

T.init = function ()
    if T.pipe == nil then
        math.randomseed(os.clock()^5)
        T.pipe = '/tmp/nvim_' .. math.random(1,10000000) .. '.pipe'
        vim.fn.serverstart(T.pipe)

        -- Set the NVIM_PIPE env var for the current shell
        io.popen("export $NVIM_PIPE='" .. T.pipe .. "'")
        -- Set the NVIM_PIPE env var for any Tmux panes/popups that are created in this session
        io.popen("tmux setenv NVIM_PIPE '".. T.pipe .. "'")
    else
        print("Pipe already initialized")
    end
end

T.teardown = function ()
    vim.fn.serverstop(T.pipe)
    io.popen("unset NVIM_PIPE")
    io.popen("tmux setenv -r NVIM_PIPE")
    T.pipe = nil
end

T.setup = function ()
    local augroup = vim.api.nvim_create_augroup("pipe_rpc", { clear = true })

    vim.api.nvim_create_autocmd("VimEnter", { callback = T.init, group = augroup })
    vim.api.nvim_create_autocmd("VimLeave", { callback = T.teardown, group = augroup })
end

T.get_pipe = function ()
    print(T.pipe)
end

return T
