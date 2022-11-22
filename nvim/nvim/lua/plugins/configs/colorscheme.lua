local T = {}

function T.setup()

    local dark = true

    if dark then
        vim.cmd('colorscheme nightfox')
        vim.cmd('set background=dark')
    else
        vim.cmd('colorscheme dayfox')
        vim.cmd('set background=light')
    end

end

return T
