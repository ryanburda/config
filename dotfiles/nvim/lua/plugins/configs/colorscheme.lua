local T = {}

T.COLORS_MAP = {}
T.COLORS_MAP['tender'] = 'tender'
T.COLORS_MAP['dayfox'] = 'Tomorrow.light'
T.COLORS_MAP['dawnfox'] = 'Embers.light'

function T.setup()

    local dark_mode = true

    if dark_mode then
        --vim.cmd('colorscheme nightfox')
        vim.cmd('colorscheme tender')
        vim.cmd('set background=dark')
    else
        vim.cmd('colorscheme dayfox')
        vim.cmd('set background=light')
    end

end

return T
