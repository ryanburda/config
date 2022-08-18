local T = {}

function T.setup()

    local function lsp_status()
        local str = ''
        if vim.lsp.buf_get_clients(0) then
            str = require('lsp-status').status()
        end
        return str
    end

    local function lsp_extra()
        -- This buffer variable exists for other LSPs to populate with relevant information.
        local str = ''
        if vim.lsp.buf_get_clients(0) then
            str = vim.api.nvim_buf_get_var(0, 'lsp_extra')
        end
        return str
    end

    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '|', right = '|'},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {},
            always_divide_middle = true,
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
            lualine_x = {lsp_extra},
            lualine_y = {lsp_status},
            lualine_z = {'location'},
        },
        tabline = {},
    }
end

return T
