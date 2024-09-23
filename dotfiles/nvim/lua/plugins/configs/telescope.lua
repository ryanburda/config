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
                    ["<C-y>"] = function()
                        local entry = require("telescope.actions.state").get_selected_entry()
                        local cb_opts = vim.opt.clipboard:get()
                        if vim.tbl_contains(cb_opts, "unnamed") then vim.fn.setreg("*", entry.path) end
                        if vim.tbl_contains(cb_opts, "unnamedplus") then
                          vim.fn.setreg("+", entry.path)
                        end
                        vim.fn.setreg("", entry.path)
                    end,
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
            advanced_git_search = {
                diff_plugin = "diffview"
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
                            -- get the selected branch name
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
    require("telescope").load_extension("advanced_git_search")

    vim.keymap.set('n', '<leader>?',  function() builtin.keymaps() end)
    vim.keymap.set('n', '<leader>f ', function() builtin.resume() end)
    vim.keymap.set('n', '<leader>ff', function() builtin.find_files() end)
    vim.keymap.set('n', '<leader>fg', function() builtin.live_grep() end)
    vim.keymap.set('n', '<leader>f/', function() builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown{ winblend = 10, previewer = false, }) end)
    vim.keymap.set('n', '<leader>fj', function() builtin.grep_string() end)
    vim.keymap.set('n', '<leader>fl', function() builtin.oldfiles() end)
    vim.keymap.set('n', '<leader>fb', function() builtin.buffers() end)
    vim.keymap.set('n', '<leader>fv', function() builtin.help_tags() end, {desc = "Search vim help"})
    vim.keymap.set('n', '<leader>fm', function() builtin.man_pages() end, {desc = "Search man pages"})
    vim.keymap.set('n', '<leader>fk', function() builtin.live_grep({search_dirs = require('plugins.configs.telescope').getqflist_files(), results_title = 'Quickfix Files'}) end)
    vim.keymap.set('n', '<leader>fK', function() builtin.quickfix() end)
    vim.keymap.set('n', '<leader>fe', function() builtin.diagnostics() end)
    vim.keymap.set('n', '<leader>du', function() builtin.git_status() end, { desc = "Diff: Show uncommitted changes (Telescope)" })
    vim.keymap.set('n', '<leader>db', function() builtin.git_branches() end, { desc = "Diff: Open branch selector in Telescope. Diff between selected branch and current is opened in DiffView"} )
    vim.keymap.set("n", '<leader>df', function() require('telescope').extensions.advanced_git_search.diff_commit_file() end)
    vim.keymap.set("n", '<leader>dc', function() require('telescope').extensions.advanced_git_search.search_log_content() end)

end

return T
