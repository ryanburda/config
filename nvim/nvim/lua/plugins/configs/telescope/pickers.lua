local T = {}

-- quickfix files picker
function T.quickfix_files(opts)
    local conf = require("telescope.config").values
    local pickers = require("telescope.pickers")
    local finders = require "telescope.finders"

    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "Quickfix Files",
        finder = finders.new_table {
            results = vim.fn.getqflist()
        },
        sorter = conf.generic_sorter(opts),
    }):find()
end

return T
