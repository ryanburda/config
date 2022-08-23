local T = {}

function T.setup()

    local opts = { noremap=true, silent=false }
    vim.api.nvim_set_keymap('n', '<leader>dd', ':DiffviewOpen<cr>'         , opts)
    vim.api.nvim_set_keymap('n', '<leader>do', ':DiffviewOpen origin/'     , opts)
    vim.api.nvim_set_keymap('n', '<leader>dl', ':DiffviewOpen '            , opts)
    vim.api.nvim_set_keymap('n', '<leader>df', ':DiffviewFileHistory<cr>'  , opts)
    vim.api.nvim_set_keymap('n', '<leader>da', ':DiffviewFileHistory .<cr>', opts)
    vim.api.nvim_set_keymap('n', '<leader>dx', ':DiffviewClose<cr>'        , opts)
    vim.api.nvim_set_keymap('n', '<leader>dr', ':DiffviewRefresh<cr>'      , opts)
    vim.api.nvim_set_keymap('n', '<leader>dt', ':DiffviewToggleFiles<cr>'  , opts)

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
