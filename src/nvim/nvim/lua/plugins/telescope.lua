local T = {}

T.setup = function()
    -- mappings
    local opts = { noremap=true, silent=true }

    vim.api.nvim_set_keymap("n", "<leader>f ", "<cmd>lua require('telescope.builtin').resume()<cr>"         , opts)
    vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>"     , opts)
    vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>"      , opts)
    vim.api.nvim_set_keymap("n", "<leader>fj", "<cmd>lua require('telescope.builtin').grep_string()<cr>"    , opts)
    vim.api.nvim_set_keymap("n", "<leader>fo", "<cmd>lua require('telescope.builtin').oldfiles()<cr>"       , opts)
    vim.api.nvim_set_keymap("n", "<leader>fD", "<cmd>lua require('telescope.builtin').diagnostics()<cr>"    , opts)
    vim.api.nvim_set_keymap("n", "<leader>fJ", "<cmd>lua require('telescope.builtin').jumplist()<cr>"       , opts)
    vim.api.nvim_set_keymap("n", "<leader>fK", "<cmd>lua require('telescope.builtin').quickfix()<cr>"       , opts)
    vim.api.nvim_set_keymap("n", "<leader>fL", "<cmd>lua require('telescope.builtin').loclist()<cr>"        , opts)
    vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>"      , opts)
    vim.api.nvim_set_keymap("n", "<leader>fk", "<cmd>lua require('telescope.builtin').keymaps()<cr>"        , opts)
    vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>"        , opts)
    vim.api.nvim_set_keymap("n", "<leader>fr", "<cmd>lua require('telescope.builtin').registers()<cr>"      , opts)
    vim.api.nvim_set_keymap("n", "<leader>fm", "<cmd>lua require('telescope.builtin').man_pages()<cr>"      , opts)
    vim.api.nvim_set_keymap("n", "<leader>fF", "<cmd>lua require('plugins.configs.telescope').ff_home()<cr>", opts)
    vim.api.nvim_set_keymap("n", "<leader>fG", "<cmd>lua require('plugins.configs.telescope').lg_home()<cr>", opts)

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

    return M
end

return T
