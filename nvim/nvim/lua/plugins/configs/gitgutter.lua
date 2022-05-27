local T = {}

function T.setup()

    vim.g.gitgutter_map_keys = 0  -- don't use default key mappings

    local opts = { noremap=true, silent=false }
    vim.api.nvim_set_keymap("n", "<leader>gj", ":GitGutterNextHunk<cr>", opts)
    vim.api.nvim_set_keymap("n", "<leader>gk", ":GitGutterPrevHunk<cr>", opts)

end

return T
