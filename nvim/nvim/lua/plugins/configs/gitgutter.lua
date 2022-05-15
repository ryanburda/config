local T = {}

T.setup = function()
    local opts = { noremap=true, silent=false }

    vim.g.gitgutter_map_keys = 0  -- don't use default key mappings

    vim.api.nvim_set_keymap("n", "<leader>dj", ":GitGutterNextHunk<cr>", opts)
    vim.api.nvim_set_keymap("n", "<leader>dk", ":GitGutterPrevHunk<cr>", opts)
end

return T
