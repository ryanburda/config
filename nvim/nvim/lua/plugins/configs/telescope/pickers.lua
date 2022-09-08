local T = {}

-- quickfix files picker
function T.quickfix_files(opts)
    local conf = require("telescope.config").values
    local pickers = require("telescope.pickers")
    local finders = require "telescope.finders"

    local getqflist_files = function()
        local qfl = vim.fn.getqflist()
        local files = {}
        local n = 0

        for k,v in pairs(qfl) do
          n=n+1
          files[n]=v.text
        end

        return files
    end

    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "Quickfix Files",
        finder = finders.new_table {
            results = getqflist_files()
        },
        sorter = conf.generic_sorter(opts),
    }):find()
end

return T
