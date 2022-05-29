local T = {}

function T.setup()
    -- mappings
    local opts = { noremap=true, silent=true }

    vim.api.nvim_set_keymap("n", "<leader>f ", "<cmd>lua require('telescope.builtin').resume()<cr>"         , opts)
    vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>"     , opts)
    vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>"      , opts)
    vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').diagnostics()<cr>"    , opts)
    vim.api.nvim_set_keymap("n", "<leader>fj", "<cmd>lua require('telescope.builtin').grep_string()<cr>"    , opts)
    vim.api.nvim_set_keymap("n", "<leader>fk", "<cmd>lua require('telescope.builtin').quickfix()<cr>"       , opts)
    vim.api.nvim_set_keymap("n", "<leader>fl", "<cmd>lua require('telescope.builtin').loclist()<cr>"        , opts)
    vim.api.nvim_set_keymap("n", "<leader>fo", "<cmd>lua require('telescope.builtin').jumplist()<cr>"       , opts)  -- 'fo' since <C-o> navigates jumplist
    vim.api.nvim_set_keymap("n", "<leader>fe", "<cmd>lua require('telescope.builtin').oldfiles()<cr>"       , opts)  -- 'fe' for file explore recent
    vim.api.nvim_set_keymap("n", "<leader>f?", "<cmd>lua require('telescope.builtin').keymaps()<cr>"        , opts)  -- ? is used for keymaps in tmux.conf too
    vim.api.nvim_set_keymap("n", "<leader>fr", "<cmd>lua require('telescope.builtin').registers()<cr>"      , opts)
    vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>"        , opts)
    vim.api.nvim_set_keymap("n", "<leader>fv", "<cmd>lua require('telescope.builtin').help_tags()<cr>"      , opts)  -- 'fv' for vim help_tags
    vim.api.nvim_set_keymap("n", "<leader>fm", "<cmd>lua require('telescope.builtin').man_pages()<cr>"      , opts)
    vim.api.nvim_set_keymap("n", "<leader>fa", "<cmd>lua require('plugins.configs.telescope').ff_home()<cr>", opts)
    vim.api.nvim_set_keymap("n", "<leader>fs", "<cmd>lua require('plugins.configs.telescope').lg_home()<cr>", opts)

    -- setup
    local previewers = require("telescope.previewers")
    local actions = require("telescope.actions")
    local sorters = require("telescope.sorters")

    require("telescope").setup({
        defaults = {
            file_sorter = sorters.get_fzy_sorter,
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

    require("telescope").load_extension("fzf")

    local M = {}

    function M.ff_home()
        require("telescope.builtin").find_files({
            prompt_title = "~/ find files",
            cwd = "~/",
            hidden = true,
            file_ignore_patterns = { ".git/" },
        })
    end

    function M.lg_home()
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
