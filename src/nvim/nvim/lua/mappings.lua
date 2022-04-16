-- map leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd([[
command! BufOnly execute '%bdelete|edit #|normal `"'
]])

vim.api.nvim_set_keymap("n", "<leader>w", ":w<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>q", ":bd<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>Q", ":bd!<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>0", ":BufOnly<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>x", ":q<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>X", ":q!<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>Y", "yy", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>j", ":bnext<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>k", ":bprevious<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>i", ":tabprevious<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>o", ":tabnext<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>t", ":tab split<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>v", "V", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>V", "{v}", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>/", ":source $MYVIMRC<cr>", { noremap = true })

-- these should match how tmux panes are created.
vim.api.nvim_set_keymap("n", "<leader>;", ":split<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>'", ":vsplit<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader><C-h>", ":vertical resize -5<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader><C-j>", ":resize -5<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader><C-k>", ":vertical resize 5<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader><C-l>", ":resize 5<cr>", { noremap = true })

-- vim-tmux-navigator
-- navigation is handled by <C-hjkl> no matter if it is a tmux pane or a vim split.
vim.api.nvim_set_keymap("n", "<C-h>", ":TmuxNavigateLeft<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", ":TmuxNavigateDown<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":TmuxNavigateUp<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", ":TmuxNavigateRight<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-;>", ":TmuxNavigatePrevious<cr>", { noremap = true })

-- telescope
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>fd", "<cmd>lua require('telescope.builtin').find_files('~/Developer/')<cr>  " TOD","O: create function", { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>fn", "<cmd>lua require('telescope.builtin').find_files('~/Developer/notes/')<cr>  " TOD","O: create function", { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>fD", "<cmd>lua require('telescope.builtin').live_grep('~/Developer/')<cr>  " TOD","O: create function", { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>fN", "<cmd>lua require('telescope.builtin').live_grep('~/Developer/notes/')<cr>  " TOD","O: create function", { noremap = true })

-- harpoon
vim.api.nvim_set_keymap("n", "<leader>ha", "<cmd>lua require(\"harpoon.mark\").add_file()<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>hh", "<cmd>lua require(\"harpoon.ui\").toggle_quick_menu()<cr>", { noremap = true })

-- vim-tmux-runner
vim.api.nvim_set_keymap("n", "<leader>ei", ":VtrOpenRunner<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ea", ":VtrAttachToPane<cr>", { noremap = true })
vim.api.nvim_set_keymap("x", "<leader>ee", ":VtrSendLinesToRunner<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ef", ":VtrSendFile<cr>", { noremap = true })

-- vim-fugitive
vim.api.nvim_set_keymap("n", "<leader>gs", ":G<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gd", ":Git diff<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gc", ":Git commit<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gp", ":Git push<cr>", { noremap = true })
-- take diff left and diff right respectively
vim.api.nvim_set_keymap("n", "<leader>gf", ":diffget //2<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gj", ":diffget //3<cr>", { noremap = true })

-- gitlinker
vim.api.nvim_set_keymap("n", "<leader>gl", "<cmd>lua require\"gitlinker\".get_buf_range_url(\"n\")<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gw", "<cmd>lua require\"gitlinker\".get_buf_range_url(\"n\", {action_callback = require\"gitlinker.actions\".open_in_browser})<cr>", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>s", ":BrowserSearch<cr>", { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>s", ":'<,'>BrowserSearch<cr>", { noremap = true })

-- Local plugin development
vim.api.nvim_set_keymap("n", "<leader>cs", "<cmd>lua require\"chtsh\"<cr>", { noremap = true })
