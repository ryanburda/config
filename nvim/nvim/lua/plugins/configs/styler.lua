local T = {}

function T.setup()

    require("styler").setup({
        themes = {
            help = { colorscheme = "carbonfox" },
            markdown = { colorscheme = "nordfox" },
        },
    })

end

return T
