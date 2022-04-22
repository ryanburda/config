-- mappings
local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap("n", "<leader>f " , "<cmd>lua require('telescope.builtin').resume()<cr>"     , opts)
vim.api.nvim_set_keymap("n", "<leader>ff" , "<cmd>lua require('telescope.builtin').find_files()<cr>" , opts)
vim.api.nvim_set_keymap("n", "<leader>fg" , "<cmd>lua require('telescope.builtin').live_grep()<cr>"  , opts)
vim.api.nvim_set_keymap("n", "<leader>fh" , "<cmd>lua require('telescope.builtin').help_tags()<cr>"  , opts)
vim.api.nvim_set_keymap("n", "<leader>fj" , "<cmd>lua require('telescope.builtin').grep_string()<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>fo" , "<cmd>lua require('telescope.builtin').jumplist()<cr>"   , opts)
vim.api.nvim_set_keymap("n", "<leader>fk" , "<cmd>lua require('telescope.builtin').keymaps()<cr>"    , opts)
vim.api.nvim_set_keymap("n", "<leader>fl" , "<cmd>lua require('telescope.builtin').oldfiles()<cr>"   , opts)
vim.api.nvim_set_keymap("n", "<leader>fb" , "<cmd>lua require('telescope.builtin').buffers()<cr>"    , opts)
vim.api.nvim_set_keymap("n", "<leader>fr" , "<cmd>lua require('telescope.builtin').registers()<cr>"  , opts)
vim.api.nvim_set_keymap("n", "<leader>fm" , "<cmd>lua require('telescope.builtin').man_pages()<cr>"  , opts)
vim.api.nvim_set_keymap("n", "<leader>fq" , "<cmd>lua require('telescope.builtin').quickfix()<cr>"   , opts)
vim.api.nvim_set_keymap("n", "<leader>faf", "<cmd>lua require('setup.telescope').ff_home()<cr>"      , opts)
vim.api.nvim_set_keymap("n", "<leader>fag", "<cmd>lua require('setup.telescope').lg_home()<cr>"      , opts)
vim.api.nvim_set_keymap("n", "<leader>fsf", "<cmd>lua require('setup.telescope').ff_scratch()<cr>"   , opts)
vim.api.nvim_set_keymap("n", "<leader>fsg", "<cmd>lua require('setup.telescope').lg_scratch()<cr>"   , opts)
vim.api.nvim_set_keymap("n", "<leader>fdf", "<cmd>lua require('setup.telescope').ff_developer()<cr>" , opts)
vim.api.nvim_set_keymap("n", "<leader>fdg", "<cmd>lua require('setup.telescope').lg_developer()<cr>" , opts)
vim.api.nvim_set_keymap("n", "<leader>fcf", "<cmd>lua require('setup.telescope').ff_config()<cr>"    , opts)
vim.api.nvim_set_keymap("n", "<leader>fcg", "<cmd>lua require('setup.telescope').lg_config()<cr>"    , opts)

-- setup
local previewers = require("telescope.previewers")
local actions = require("telescope.actions")
local sorters = require("telescope.sorters")

require("telescope").setup({
    defaults = {
        file_sorter = sorters.get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,

        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,

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
