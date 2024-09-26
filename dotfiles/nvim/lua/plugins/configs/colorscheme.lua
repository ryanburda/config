local T = {}

T.COLORSCHEME_DEFAULT = 'everforest'
T.COLORSCHEME_FILE = vim.fn.stdpath('config') .. '/.colorscheme'
T.BACKGROUND_DEFAULT = 'dark'
T.BACKGROUND_FILE = vim.fn.stdpath('config') .. '/.background'

function T.set_colorscheme(is_setup)
    is_setup = is_setup or false

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

    -- Don't reload the colorizer plugin if neovim is just starting up.
    if is_setup == false then
        -- Reload colorizer plugin.
        -- NOTE: must refresh the current buffer manually (`:e`)
        vim.cmd('silent Lazy reload nvim-colorizer.lua')
    end

end

function T.setup()

    T.set_colorscheme(true)

    -- update the colorscheme when the colorscheme file changes.
    local fwatch = require('fwatch')
    fwatch.watch(T.COLORSCHEME_FILE, {
        on_event = function()
            -- sleep for a bit to make sure the background file is done being written to as well.
            vim.schedule(function() vim.defer_fn(T.set_colorscheme, 100) end)
        end
    })

end

return T
