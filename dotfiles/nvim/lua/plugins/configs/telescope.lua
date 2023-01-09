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

function T.ff_playground()
    require("telescope.builtin").find_files({
        prompt_title = "~/Developer/playgrounds/ find files",
        cwd = "~/Developer/playgrounds/",
        hidden = true,
        file_ignore_patterns = { ".git/" },
    })
end

function T.lg_playground()
    require("telescope.builtin").live_grep({
        prompt_title = "~/Developer/playgrounds grep",
        cwd = "~/Developer/playgrounds/",
        hidden = true,
        file_ignore_patterns = { ".git/" },
    })
end

function T.setup()

    local builtin = require("telescope.builtin")
    local sorters = require("telescope.sorters")
    local actions = require("telescope.actions")
    local actions_state = require("telescope.actions.state")
    local previewers = require("telescope.previewers")
    local cf_actions = require('telescope').extensions.changed_files.actions

    local function move_cwd_up(prompt_bufnr, fn)
        -- Move cwd up one directory
        local picker = actions_state.get_current_picker(prompt_bufnr)
        local parent_dir = vim.fn.fnamemodify(picker.cwd, ":h")
        fn({cwd = parent_dir, results_title = parent_dir })
    end

    local function switch_picker(prompt_bufnr, fn)
        -- Toggle between find_files and live_grep
        local picker = actions_state.get_current_picker(prompt_bufnr)
        local cwd = picker.cwd
        fn({cwd = cwd, results_title = cwd})
    end

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
        },
        pickers = {
            find_files = {
                cwd = vim.fn.getcwd(),
                results_title = vim.fn.getcwd(),
                find_command = { "rg", "--ignore", "--follow", "--files", "--hidden", "-g", "!.git/" },
                mappings = {
                    i = {
                        ["<C-h>"] = function(prompt_bufnr) move_cwd_up(prompt_bufnr, builtin.find_files) end,
                        ["<C-g>"] = function(prompt_bufnr) switch_picker(prompt_bufnr, builtin.live_grep) end,
                        ["<C-f>"] = function() end,  -- noop
                    },
                },
            },
            live_grep = {
                cwd = vim.fn.getcwd(),
                results_title = vim.fn.getcwd(),
                find_command = { "rg", "--ignore", "-L", "--files", "--hidden", "-g", "!.git/" },
                mappings = {
                    i = {
                        ["<C-h>"] = function(prompt_bufnr) move_cwd_up(prompt_bufnr, builtin.live_grep) end,
                        ["<C-f>"] = function(prompt_bufnr) switch_picker(prompt_bufnr, builtin.find_files) end,
                        ["<C-g>"] = function() end,  -- noop
                    },
                },
            },
            git_branches = {
                mappings = {
                    i = {
                        ["<C-f>"] = cf_actions.find_changed_files,
                        ["<cr>"] = function(prompt_bufnr)
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
                        ["<C-f>"] = cf_actions.find_changed_files,
                        ["<cr>"] = function(prompt_bufnr)
                            -- get the selected file name
                            local entry = require("telescope.actions.state").get_selected_entry()
                            -- close telescope
                            require("telescope.actions").close(prompt_bufnr)
                            -- open diffview
                            vim.cmd('DiffviewOpen ' .. entry.value)
                        end,
                    }
                }
            },
        }
    })

    require('telescope').load_extension('fzf')
    require("telescope").load_extension("changed_files")
    require('telescope').load_extension('tmuxinator')

end

return T
