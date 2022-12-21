local T = {}

function T.setup()

    local augroup = vim.api.nvim_create_augroup("zsh", { clear = true })

    vim.api.nvim_create_autocmd("VimEnter", {
        pattern = { "*/Developer/playgrounds/zsh/*", },
        callback = function() vim.cmd('VtrOpenRunner') end,
        group = augroup
    })

end

return T
