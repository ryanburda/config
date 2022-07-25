local T = {}

function T.setup()

    require("indent_blankline").setup {
        space_char_blankline = " ",
        show_current_context = true,
    }

end

return T
