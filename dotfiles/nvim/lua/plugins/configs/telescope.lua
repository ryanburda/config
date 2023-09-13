local T = {}

-- setup
function T.getqflist_files()
    local qfl = vim.fn.getqflist()
    local files = {}

    for _,v in pairs(qfl) do
        table.insert(files, v.text)
    end

    return files
end

function T.setup()

    local builtin = require("telescope.builtin")
    local sorters = require("telescope.sorters")
    local actions = require("telescope.actions")
    local previewers = require("telescope.previewers")
    local cf_actions = require('telescope').extensions.changed_files.actions
    local lga_actions = require("telescope-live-grep-args.actions")

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
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
            live_grep_args = {
                auto_quoting = true, -- enable/disable auto-quoting
                -- define mappings, e.g.
                mappings = { -- extend mappings
                    i = {
                        ["<C-f>"] = lga_actions.quote_prompt({ postfix = " --iglob **/" }),
                    },
                },
            },
        },
        pickers = {
            find_files = {
                cwd = vim.fn.getcwd(),
                results_title = vim.fn.getcwd(),
                find_command = { "rg", "--ignore", "--follow", "--files", "--hidden", "-g", "!.git/" },
            },
            live_grep = {
                cwd = vim.fn.getcwd(),
                results_title = vim.fn.getcwd(),
                find_command = { "rg", "--ignore", "-L", "--files", "--hidden", "-g", "!.git/" },
            },
            git_branches = {
                mappings = {
                    i = {
                        ["<C-o>"] = actions.git_switch_branch,
                        ["<C-l>"] = cf_actions.find_changed_files,
                        ["<CR>"] = function(prompt_bufnr)
                            -- get the selected file name
                            local entry = require("telescope.actions.state").get_selected_entry()
                            -- close telescope
                            require("telescope.actions").close(prompt_bufnr)
                            -- open diffview
                            vim.cmd('DiffviewOpen ' .. entry.name)
                        end,
                    }
                }
            },
            git_commits = {
                mappings = {
                    i = {
                        ["<C-o>"] = actions.git_checkout,
                        ["<C-l>"] = cf_actions.find_changed_files,
                        ["<CR>"] = function(prompt_bufnr)
                            -- get the selected commit hash
                            local entry = require("telescope.actions.state").get_selected_entry()
                            -- close telescope
                            require("telescope.actions").close(prompt_bufnr)
                            -- open diffview
                            vim.cmd('DiffviewOpen ' .. entry.value)
                        end,
                    }
                }
            },
        },
    })

    require('telescope').load_extension('fzf')
    require("telescope").load_extension("changed_files")

    vim.keymap.set('n', "<leader>f ", "<cmd>lua require('telescope.builtin').resume()<cr>")
    vim.keymap.set('n', "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
    vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
    vim.keymap.set('n', "<leader>f/", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>")
    vim.keymap.set('n', "<leader>fj", "<cmd>lua require('telescope.builtin').grep_string()<cr>")
    vim.keymap.set('n', "<leader>fl", "<cmd>lua require('telescope.builtin').oldfiles()<cr>")
    vim.keymap.set('n', "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
    vim.keymap.set('n', "<leader>fv", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
    vim.keymap.set('n', "<leader>fm", "<cmd>lua require('telescope.builtin').man_pages()<cr>")
    vim.keymap.set('n', "<leader>fk", "<cmd>lua require('telescope.builtin').live_grep({search_dirs = require('plugins.configs.telescope').getqflist_files(), results_title = 'Quickfix Files'})<cr>")
    vim.keymap.set('n', "<leader>fK", "<cmd>lua require('telescope.builtin').quickfix()<cr>")
    vim.keymap.set('n', "<leader>fc", "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>")
    vim.keymap.set('n', "<leader>dl", "<cmd>lua require('telescope.builtin').git_status()<cr>")
    vim.keymap.set('n', "<leader>db", "<cmd>lua require('telescope.builtin').git_branches()<cr>")
    vim.keymap.set('n', "<leader>dc", "<cmd>lua require('telescope.builtin').git_commits()<cr>")
    vim.keymap.set('n', "<leader>?", "<cmd>lua require('telescope.builtin').keymaps()<cr>")

end

return T
