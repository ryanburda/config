local T = {}

function T.setup()

    require('neoscroll').setup({
        easing_function = "sine",
        time = 120
    })

end

return T
