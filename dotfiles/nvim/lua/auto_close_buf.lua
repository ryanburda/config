local T = {}

T.augroup = vim.api.nvim_create_augroup("auto_close_buf", { clear = true })

function T.setup()
    vim.api.nvim_create_autocmd(
        "BufAdd",
        {
            callback = function(t)
                T.watch(vim.fn.expand("<afile>:p"))
            end,
            group = T.augroup
        }
    )
end

function T.watch(file)

    local fwatch = require('fwatch')
    local handle = fwatch.watch(file, {
        on_event = function()
            local f = io.open(file, "r")
            if not f then
                vim.schedule(function()
                    require('bufdelete').bufdelete(file, true)
                end)
            end
        end
    })

    vim.api.nvim_create_autocmd(
        "BufDelete",
        {
            callback = function()
                fwatch.unwatch(handle)
            end,
            group = T.augroup
        }
    )

end

return T
