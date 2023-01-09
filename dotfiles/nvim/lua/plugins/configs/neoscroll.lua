local T = {}

function T.setup()

    require('neoscroll').setup({
        mappings = {'<C-u>', '<C-d>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
        easing_function = "sine",
        time = 120
    })

end

return T
