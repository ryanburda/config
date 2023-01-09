local T = {}

function T.setup()

    require("styler").setup({
        themes = {
            man = { colorscheme = "carbonfox" },
            help = { colorscheme = "carbonfox" },
            markdown = { colorscheme = "nordfox" },
        },
    })

end

return T
