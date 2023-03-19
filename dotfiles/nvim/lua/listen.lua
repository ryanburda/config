local T = {}

T.init = function ()
    if T.pipe == nil then
        math.randomseed(os.clock()^5)
        T.pipe = '/tmp/nvim_' .. math.random(1,10000000) .. '.pipe'
        vim.fn.serverstart(T.pipe)
        vim.cmd("let $NVIM_PIPE = '" .. T.pipe .. "'")
    else
        print("Pipe already initialized")
    end
end

T.teardown = function ()
    vim.fn.serverstop(T.pipe)
    T.pipe = nil
end

T.setup = function ()
    local augroup = vim.api.nvim_create_augroup("listen_rpc", { clear = true })

    vim.api.nvim_create_autocmd("VimEnter", { callback = T.init, group = augroup })
    vim.api.nvim_create_autocmd("VimLeave", { callback = T.teardown, group = augroup })
end

T.get_pipe = function ()
    print(T.pipe)
end

return T
