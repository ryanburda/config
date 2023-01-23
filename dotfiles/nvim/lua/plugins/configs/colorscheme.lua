local T = {}

T.COLORSCHEME_DEFAULT = 'nightfox'
T.COLORSCHEME_FILE = vim.fn.stdpath('config') .. '/.colorscheme'

-- Maps a neovim colorscheme to other attributes
T.COLORS_MAP = {}
T.COLORS_MAP['nightfox'] = {
    ['alacritty'] = 'Ayu-Mirage',
    ['background'] = 'dark',
}
T.COLORS_MAP['tender'] = {
    ['alacritty'] = 'tender',
    ['background'] = 'dark',
}
T.COLORS_MAP['dayfox'] = {
    ['alacritty'] = 'Tomorrow.light',
    ['background'] = 'light',
}
T.COLORS_MAP['dawnfox'] = {
    ['alacritty'] = 'Embers.light',
    ['background'] = 'light',
}

function T.setup()

    -- create the colorscheme file if it doesn't already exist
    if io.open(T.COLORSCHEME_FILE, "r") == nil then
        T.change_colorscheme(T.COLORSCHEME_DEFAULT)
    end

    -- read the colorscheme from the colorscheme file
    local colorscheme_file = io.open(T.COLORSCHEME_FILE, "r")
    local colorscheme = colorscheme_file:read("*a")
    colorscheme_file:close()

    -- check if the colorscheme file has a bad value
    if T.COLORS_MAP[colorscheme] == nil then
        print('colorscheme ' .. colorscheme .. ' does not exist. Setting default colorscheme: ' .. T.COLORSCHEME_DEFAULT)
        T.change_colorscheme(T.COLORSCHEME_DEFAULT)
        colorscheme = T.COLORSCHEME_DEFAULT
    end

    -- set the colorscheme, background color, and alacritty theme
    vim.cmd('colorscheme ' .. colorscheme)
    vim.cmd('set background=' .. T.COLORS_MAP[colorscheme]['background'])
    os.execute("alacritty-themes " .. T.COLORS_MAP[colorscheme]['alacritty'])

end

function T.change_colorscheme(colorscheme)
    local colorscheme_file = io.open(T.COLORSCHEME_FILE, "w+")
    colorscheme_file:write(colorscheme)
    colorscheme_file:close()
end

return T
