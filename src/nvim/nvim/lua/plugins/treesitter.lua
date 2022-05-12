local T = {}

T.setup = function()
    local configs = require('nvim-treesitter.configs')

    configs.setup {
        ensure_installed = 'all',
        ignore_install = { 'phpdoc' },
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
    }
end

return T
