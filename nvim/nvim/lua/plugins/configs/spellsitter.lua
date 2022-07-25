local T = {}

function T.setup()

    local t = require('spellsitter')

    t.setup {
        highlight = {
            enable = true,
        },
    }

end

return T
