local T = {}

function T.setup()

    -- mappings
    local opts = { noremap=true, silent=true }

    vim.api.nvim_set_keymap(
        "n",
        "<leader>f ",
        "<cmd>lua require('telescope.builtin').resume()<cr>",
        opts
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>ff",
        "<cmd>lua require('telescope.builtin').find_files({ cwd = vim.fn.getcwd(), results_title = vim.fn.getcwd(), })<cr>",
        opts
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>fg",
        "<cmd>lua require('telescope.builtin').live_grep({ cwd = vim.fn.getcwd(), results_title = vim.fn.getcwd(), })<cr>" ,
        opts
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>fh",
        "<cmd>lua require('telescope.builtin').diagnostics()<cr>",
        opts
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>fj",
        "<cmd>lua require('telescope.builtin').grep_string()<cr>",
        opts
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>fk",
        "<cmd>lua require('telescope.builtin').quickfix()<cr>",
        opts
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>fl",
        "<cmd>lua require('telescope.builtin').loclist()<cr>",
        opts
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>fo",  -- 'fo' since <C-o> navigates jumplist
        "<cmd>lua require('telescope.builtin').jumplist()<cr>",
        opts
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>fe",  -- 'fe' for file explore recent
        "<cmd>lua require('telescope.builtin').oldfiles()<cr>",
        opts
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>f?",
        "<cmd>lua require('telescope.builtin').keymaps()<cr>",
        opts
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>fr",
        "<cmd>lua require('telescope.builtin').registers()<cr>",
        opts
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>fb",
        "<cmd>lua require('telescope.builtin').buffers()<cr>",
        opts
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>fv",
        "<cmd>lua require('telescope.builtin').help_tags()<cr>",
        opts
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>fm",
        "<cmd>lua require('telescope.builtin').man_pages()<cr>",
        opts
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>fd",
        "<cmd>lua require('telescope.builtin').git_status()<cr>",
        opts
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>fs",
        "<cmd>lua require('telescope.builtin').git_branches()<cr>",
        opts
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>fc",
        "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
        opts
    )

    -- setup
    local builtin = require("telescope.builtin")
    local sorters = require("telescope.sorters")
    local actions = require("telescope.actions")
    local actions_state = require("telescope.actions.state")
    local previewers = require("telescope.previewers")
    local cf_actions = require('telescope').extensions.changed_files.actions

    local getcwd = function(prompt_bufnr)
        local picker = actions_state.get_current_picker(prompt_bufnr)
        return (picker.cwd and picker.cwd ~= '') and picker.cwd or vim.fn.getcwd()
    end

    require("telescope").setup({
        defaults = {
            file_sorter = sorters.get_fzy_sorter,
            color_devicons = true,
            file_previewer = previewers.vim_buffer_cat.new,
            grep_previewer = previewers.vim_buffer_vimgrep.new,
            qflist_previewer = previewers.vim_buffer_qflist.new,
            layout_strategy = 'vertical',
            layout_config = {
                vertical = { width = 0.6 }
            },
            mappings = {
                i = {
                    ["<C-x>"] = false,
                    ["<C-k>"] = actions.send_to_qflist,
                    ["<C-o>"] = function(prompt_bufnr)
                        -- Open buffer and resume prompt
                        actions.select_default(prompt_bufnr)
                        builtin.resume()
                    end,
                },
            },
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            },
        },
        pickers = {
            find_files = {
                find_command = { "rg", "--ignore", "-L", "--files" },
                mappings = {
                    i = {
                        ["<C-h>"] = function(prompt_bufnr)
                            -- Move cwd up one directory
                            local cwd = getcwd(prompt_bufnr)
                            local parent_dir = vim.fn.fnamemodify(cwd, ":h")
                            builtin.find_files({cwd = parent_dir, results_title = parent_dir })
                        end,
                        ["<C-g>"] = function(prompt_bufnr)
                            -- Toggle between find_files and live_grep
                            local cwd = getcwd(prompt_bufnr)
                            builtin.live_grep({cwd = cwd, results_title = cwd})
                        end,
                        ["<C-f>"] = function()
                            -- noop
                        end,
                    },
                },
            },
            live_grep = {
                find_command = { "rg", "--ignore", "-L", "--files" },
                mappings = {
                    i = {
                        ["<C-h>"] = function(prompt_bufnr)
                            -- Move cwd up one directory
                            local cwd = getcwd(prompt_bufnr)
                            local parent_dir = vim.fn.fnamemodify(cwd, ":h")
                            builtin.live_grep({cwd = parent_dir, results_title = parent_dir })
                        end,
                        ["<C-f>"] = function(prompt_bufnr)
                            -- Toggle between find_files and live_grep
                            local cwd = getcwd(prompt_bufnr)
                            builtin.find_files({cwd = cwd, results_title = cwd})
                        end,
                        ["<C-g>"] = function()
                            -- noop
                        end,
                    },
                },
            },
            git_branches = {
                mappings = {
                    i = {
                        ["<cr>"] = cf_actions.find_changed_files
                    }
                }
            },
        }
    })

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("changed_files")

end

-- quickfix files picker
function T.quickfix_files(opts)
    local conf = require("telescope.config").values
    local pickers = require("telescope.pickers")
    local finders = require "telescope.finders"

    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "Quickfix Files",
        finder = finders.new_table {
            results = vim.fn.getqflist()
        },
        sorter = conf.generic_sorter(opts),
    }):find()
end

return T
