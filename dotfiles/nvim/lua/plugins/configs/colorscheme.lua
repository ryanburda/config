local T = {}

T.COLORSCHEME_DEFAULT = 'kanagawa-wave'
T.COLORSCHEME_FILE = vim.fn.stdpath('config') .. '/.colorscheme'
T.BACKGROUND_DEFAULT = 'dark'
T.BACKGROUND_FILE = vim.fn.stdpath('config') .. '/.background'

function T.set_colorscheme()

    -- create the colorscheme file if it doesn't already exist
    if io.open(T.COLORSCHEME_FILE, "r") == nil then
        local colorscheme_file = io.open(T.COLORSCHEME_FILE, "w+")
        colorscheme_file:write(T.COLORSCHEME_DEFAULT)
        colorscheme_file:close()
    end

    -- create the background file if it doesn't already exist
    if io.open(T.BACKGROUND_FILE, "r") == nil then
        local background_file = io.open(T.BACKGROUND_FILE, "w+")
        background_file:write(T.BACKGROUND_DEFAULT)
        background_file:close()
    end

    -- read the colorscheme from the colorscheme file
    local colorscheme_file = io.open(T.COLORSCHEME_FILE, "r")
    local colorscheme = colorscheme_file:read("*a")
    colorscheme_file:close()

    -- read the background from the background file
    local background_file = io.open(T.BACKGROUND_FILE, "r")
    local background = background_file:read("*a")
    background_file:close()

    vim.cmd('set background=' .. background)
    vim.cmd('colorscheme ' .. colorscheme)
    vim.cmd('set background=' .. background)
    vim.cmd('colorscheme ' .. colorscheme)

end

function T.setup()

    T.set_colorscheme()

    -- update the colorscheme when the colorscheme file changes.
    local fwatch = require('fwatch')
    fwatch.watch(T.COLORSCHEME_FILE, {
        on_event = function()
            vim.schedule(T.set_colorscheme)
        end
    })

end

return T
