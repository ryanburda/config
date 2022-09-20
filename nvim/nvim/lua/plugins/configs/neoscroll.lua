local T = {}

function T.setup()

    require('neoscroll').setup({
        easing_function = "cubic",
        time = 125
    })

end

return T
