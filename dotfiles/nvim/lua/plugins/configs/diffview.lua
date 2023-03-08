local T = {}

function T.setup()

    local actions = require("diffview.actions")

    require("diffview").setup({
        enhanced_diff_hl = true,
        keymaps = {
            view = {
                ["<leader>dh"] = actions.conflict_choose("ours"),
                ["<leader>dl"] = actions.conflict_choose("theirs"),
            },
        },
    })

    vim.keymap.set('n', '<leader>dd', ':DiffviewOpen<cr>', {desc = "Diff View" })
    vim.keymap.set('n', '<leader>df', ':DiffviewFileHistory %<cr>', {desc = "Diff View with current buffer commit history"})
    vim.keymap.set('n', '<leader>dF', ':DiffviewFileHistory<cr>', {desc = "Diff View with full repo commit history"})
    vim.keymap.set('n', '<leader>dx', ':DiffviewClose<cr>', {desc = "Diff View close"})

end

return T
