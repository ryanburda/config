local T = {}

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

function T.setup()
    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '|', right = '|'},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {},
            always_divide_middle = true,
            globalstatus = false,
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {
                {
                    'filename',
                    file_status = true,
                    path = 1
                }
            },
            lualine_x = {lsp_status, lsp_extra},
            lualine_y = {'filetype'},
            lualine_z = {'progress', 'location'}
        },
        tabline = {},
        extensions = {},
    }
end

return T