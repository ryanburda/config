local T = {}

T.setup = function()
    local lsp_status = function()
        local str = ''
        if vim.lsp.buf_get_clients(0) then
            str = require('lsp-status').status()
        end
        return str
    end

    local lsp_extra = function()
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
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {},
            always_divide_middle = true,
            globalstatus = false,
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {'filename'},
            lualine_x = {lsp_status, lsp_extra},
            lualine_y = {'filetype'},
            lualine_z = {'progress', 'location'}
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        extensions = {},
    }
end

return T
