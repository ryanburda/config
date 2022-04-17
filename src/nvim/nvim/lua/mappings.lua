-- map leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd([[
command! BufOnly execute '%bdelete|edit #|normal `"'
]])

vim.api.nvim_set_keymap("n", "Y"        , "yy"                  , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>w", ":w<cr>"              , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>q", ":bd<cr>"             , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>Q", ":bd!<cr>"            , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>0", ":BufOnly<cr>"        , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>x", ":q<cr>"              , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>X", ":q!<cr>"             , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>j", ":bnext<cr>"          , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>k", ":bprevious<cr>"      , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>i", ":tabprevious<cr>"    , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>o", ":tabnext<cr>"        , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>t", ":tab split<cr>"      , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>v", "V"                   , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>V", "{v}"                 , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>/", ":source $MYVIMRC<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>;", ":split<cr><C-w>j"    , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>'", ":vsplit<cr><C-w>l"   , { noremap = true })

-- vim-tmux-navigator
-- navigation is handled by <C-hjkl> no matter if it is a tmux pane or a vim split.
vim.api.nvim_set_keymap("n", "<C-h>", ":TmuxNavigateLeft<cr>"    , { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", ":TmuxNavigateDown<cr>"    , { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":TmuxNavigateUp<cr>"      , { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", ":TmuxNavigateRight<cr>"   , { noremap = true })
vim.api.nvim_set_keymap("n", "<C-;>", ":TmuxNavigatePrevious<cr>", { noremap = true })

-- telescope
vim.api.nvim_set_keymap("n", "<leader>ff" , "<cmd>lua require('telescope.builtin').find_files()<cr>"                 , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fg" , "<cmd>lua require('telescope.builtin').live_grep()<cr>"                  , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fh" , "<cmd>lua require('telescope.builtin').help_tags()<cr>"                  , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fj" , "<cmd>lua require('telescope.builtin').jumplist()<cr>"                   , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fk" , "<cmd>lua require('telescope.builtin').keymaps()<cr>"                    , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fl" , "<cmd>lua require('telescope.builtin').oldfiles()<cr>"                   , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fb" , "<cmd>lua require('telescope.builtin').buffers()<cr>"                    , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fr" , "<cmd>lua require('telescope.builtin').registers()<cr>"                  , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fm" , "<cmd>lua require('telescope.builtin').man_pages()<cr>"                  , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>faf", "<cmd>lua require('setup.telescope').ff_home({ hidden = true })<cr>"     , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fag", "<cmd>lua require('setup.telescope').lg_home({ hidden = true })<cr>"     , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fsf", "<cmd>lua require('setup.telescope').ff_scratch({ hidden = true })<cr>"  , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fsg", "<cmd>lua require('setup.telescope').lg_scratch({ hidden = true })<cr>"  , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fdf", "<cmd>lua require('setup.telescope').ff_developer({ hidden = true })<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fdg", "<cmd>lua require('setup.telescope').lg_developer({ hidden = true })<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fcf", "<cmd>lua require('setup.telescope').ff_config({ hidden = true })<cr>"   , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fcg", "<cmd>lua require('setup.telescope').lg_config({ hidden = true })<cr>"   , { noremap = true })

-- harpoon
vim.api.nvim_set_keymap("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>"       , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { noremap = true })

-- vim-tmux-runner
vim.api.nvim_set_keymap("n", "<leader>ei", ":VtrOpenRunner<cr>"       , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ea", ":VtrAttachToPane<cr>"     , { noremap = true })
vim.api.nvim_set_keymap("x", "<leader>ee", ":VtrSendLinesToRunner<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ef", ":VtrSendFile<cr>"         , { noremap = true })

-- vim-fugitive
vim.api.nvim_set_keymap("n", "<leader>gs", ":G<cr>"          , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gd", ":Git diff<cr>"   , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gc", ":Git commit<cr>" , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gp", ":Git push<cr>"   , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gf", ":diffget //2<cr>", { noremap = true })  -- take diff left
vim.api.nvim_set_keymap("n", "<leader>gj", ":diffget //3<cr>", { noremap = true })  -- take diff right

-- gitlinker
vim.api.nvim_set_keymap("n", "<leader>gl", "<cmd>lua require('gitlinker').get_buf_range_url('n')<cr>"                                                                  , { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gw", "<cmd>lua require('gitlinker').get_buf_range_url('n', {action_callback = require('gitlinker.actions').open_in_browser})<cr>", { noremap = true })

-- Browser Search
vim.api.nvim_set_keymap("n", "<leader>s", ":BrowserSearch<cr>"     , { noremap = true })
vim.api.nvim_set_keymap("v", "<leader>s", ":'<,'>BrowserSearch<cr>", { noremap = true })

-- Local plugin development
vim.api.nvim_set_keymap("n", "<leader>cs", "<cmd>lua require('chtsh').func()<cr>", { noremap = true })
