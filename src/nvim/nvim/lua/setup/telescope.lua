local previewers = require("telescope.previewers")
local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,

        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
            },
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
})

require("telescope").load_extension("fzy_native")

local M = {}

M.ff_home = function()
    require("telescope.builtin").find_files({
        prompt_title = "~/ find files",
        cwd = "~/",
        hidden = true,
        file_ignore_patterns = { ".git/" },
    })
end

M.lg_home = function()
    require("telescope.builtin").live_grep({
        prompt_title = "~/ grep",
        cwd = "~/",
        hidden = true,
        file_ignore_patterns = { ".git/" },
    })
end

M.ff_developer = function()
    require("telescope.builtin").find_files({
        prompt_title = "~/Developer find files",
        cwd = "~/Developer",
        hidden = true,
        file_ignore_patterns = { ".git/" },
    })
end

M.lg_developer = function()
    require("telescope.builtin").live_grep({
        prompt_title = "~/Developer grep",
        cwd = "~/Developer",
        hidden = true,
        file_ignore_patterns = { ".git/" },
    })
end

M.ff_scratch = function()
    require("telescope.builtin").find_files({
        prompt_title = "~/Developer/scratch find files",
        cwd = "~/Developer/scratch",
        hidden = true,
        file_ignore_patterns = { ".git/" },
    })
end

M.lg_scratch = function()
    require("telescope.builtin").live_grep({
        prompt_title = "~/Developer/scratch grep",
        cwd = "~/Developer/scratch",
        hidden = true,
        file_ignore_patterns = { ".git/" },
    })
end

M.ff_config = function()
    require("telescope.builtin").find_files({
        prompt_title = "~/Developer/config find files",
        cwd = "~/Developer/config",
        hidden = true,
        file_ignore_patterns = { ".git/" },
    })
end

M.lg_config = function()
    require("telescope.builtin").live_grep({
        prompt_title = "~/Developer/config grep",
        cwd = "~/Developer/config",
        hidden = true,
        file_ignore_patterns = { ".git/" },
    })
end

return M
