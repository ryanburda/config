local T = {}

function T.setup()

    local opts = { noremap=true, silent=false }
    vim.api.nvim_set_keymap('n', '<leader>dd', ':DiffviewOpen<cr>'       , opts)
    vim.api.nvim_set_keymap('n', '<leader>do', ':DiffviewOpen origin/'   , opts)
    vim.api.nvim_set_keymap('n', '<leader>dO', ':DiffviewOpen '          , opts)
    vim.api.nvim_set_keymap('n', '<leader>dD', ':DiffviewFileHistory<cr>', opts)
    vim.api.nvim_set_keymap('n', '<leader>dx', ':DiffviewClose<cr>'      , opts)

    require("diffview").setup({
        enhanced_diff_hl = true,
        file_panel = {
            listing_style = "tree",
            tree_options = {
                flatten_dirs = true,
                folder_statuses = "only_folded",
            },
            win_config = {
                position = "left",
                width = 40,
            },
        },
    })

end

return T
