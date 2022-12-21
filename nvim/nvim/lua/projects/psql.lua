local T = {}

function T.setup()

    local augroup = vim.api.nvim_create_augroup("psql", { clear = true })

    vim.api.nvim_create_autocmd("VimEnter", {
        pattern = { "*/Developer/playgrounds/psql/*", },
        callback = function() vim.cmd('VtrAttachToPane') end,
        group = augroup
    })

end

return T
