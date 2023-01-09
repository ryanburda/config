local T = {}

function T.setup()

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
