local T = {}

function T.setup()

    local opts = { noremap=true, silent=false }
    vim.api.nvim_set_keymap('n', '<leader>dd', ':DiffviewOpen<cr>'         , opts)
    vim.api.nvim_set_keymap('n', '<leader>dh', ':DiffviewFileHistory %<cr>', opts)
    vim.api.nvim_set_keymap('n', '<leader>dH', ':DiffviewFileHistory<cr>'  , opts)
    vim.api.nvim_set_keymap('n', '<leader>dx', ':DiffviewClose<cr>'        , opts)

    local actions = require("diffview.actions")

    require("diffview").setup({
        enhanced_diff_hl = true,
        file_panel = {
            listing_style = "tree",
            tree_options = {
                flatten_dirs = true,
                folder_statuses = "only_folded",
            },
            win_config = {
                position = "bottom",
                height = 20
            },
        },
        keymaps = {
            view = {
                ["<leader>dh"] = actions.conflict_choose("ours"),
                ["<leader>dl"] = actions.conflict_choose("theirs"),
            },
        },
    })

end

return T
