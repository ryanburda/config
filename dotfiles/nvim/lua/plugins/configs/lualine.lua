local T = {}

function T.setup()

    local is_copilot_on = function()
        if vim.g['is_copilot_on'] then
            return ""
        else
            return ""
        end
    end

    local has_server_pipe = function()
        if require('server').get_pipe() ~= nil then
            return ""
        else
            return ""
        end
    end

    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = 'auto',
            globalstatus = true,
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = '' },
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
            lualine_x = { 'diagnostics', is_copilot_on, has_server_pipe, },
            lualine_y = { 'progress', },
            lualine_z = { 'location' },
        },
        tabline = {},
    }

end

return T
