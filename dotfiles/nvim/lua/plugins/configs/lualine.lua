local T = {}

function T.setup()

    local function copilot_on()
        if vim.g['is_copilot_on'] then
            return ""
        else
            return ""
        end
    end

    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = 'auto',
            globalstatus = true,
            section_separators = '',
            component_separators = '',
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
            lualine_x = { copilot_on, require('pipe').get_pipe, 'diagnostics', },
            lualine_y = { 'progress', },
            lualine_z = { 'location' },
        },
        tabline = {},
    }

end

return T
