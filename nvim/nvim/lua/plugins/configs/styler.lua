local T = {}

function T.setup()

    require("styler").setup({
        themes = {
            help = { colorscheme = "terafox" },
            markdown = { colorscheme = "nordfox" },
        },
    })

end

return T
