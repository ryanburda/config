local T = {}

function T.setup()

    require('neoscroll').setup({
        easing_function = "cubic",
        time = 100
    })

end

return T
