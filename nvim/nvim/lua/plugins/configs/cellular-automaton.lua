local T = {}

function T.setup()

    vim.keymap.set("n", "<leader>\\", "<cmd>CellularAutomaton make_it_rain<CR>")

end

return T
