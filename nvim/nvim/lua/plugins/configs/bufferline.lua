local T = {}

function T.setup()
    require('bufferline').setup({
        options = {
            offsets = {
                {
                    filetype = "NvimTree",
                    highlight = "Directory",
                    separator = true -- use a "true" to enable the default, or set your own character
                },
                {
                    filetype = "Outline",
                    highlight = "Directory",
                    separator = true -- use a "true" to enable the default, or set your own character
                }
            }
        }
    })
end

return T
