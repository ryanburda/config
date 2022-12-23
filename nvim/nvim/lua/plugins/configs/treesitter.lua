local T = {}

function T.setup()

    require('nvim-treesitter.configs').setup({
        auto_install = true,
        incremental_selection = {
            enable = true,
            keymaps =  {
                node_incremental = '<C-n>',
                node_decremental = '<C-p>',
            },
        },
    })

end

return T
