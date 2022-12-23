local T = {}

function T.setup()

    vim.keymap.set("n", "<leader>ts", ":TSPlaygroundToggle<CR>")

end

return T
