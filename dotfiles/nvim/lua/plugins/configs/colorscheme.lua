local T = {}

function T.setup()

    local dark_mode = true

    if dark_mode then
        --vim.cmd('colorscheme nightfox')
        vim.cmd('colorscheme melange')
        vim.cmd('set background=dark')
    else
        vim.cmd('colorscheme dayfox')
        vim.cmd('set background=light')
    end

end

return T
