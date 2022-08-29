local T = {}

function T.setup()

    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = 'auto',
            globalstatus = true,
        },
        extensions = {},
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff'},
            lualine_c = {
                {
                    'filename',
                    file_status = true,
                    path = 1
                },
            },
            lualine_x = { 'filetype', },
            lualine_y = { 'progress', },
            lualine_z = {'location'},
        },
        tabline = {},
    }
end

return T
