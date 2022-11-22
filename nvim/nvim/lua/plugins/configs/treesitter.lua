local T = {}

function T.setup()

    require('nvim-treesitter.configs').setup({
        auto_install = true,
        incremental_selection = {
            enable = true,
            keymaps =  {
                init_selection = '<leader>v',
                scope_incremental = '<CR>',
                node_incremental = '<TAB>',
                node_decremental = '<S-TAB>',
            },
        },
    })

end

return T
