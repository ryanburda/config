local opts = { noremap=true, silent=false }

-- Vim-fugitive
vim.api.nvim_set_keymap('n', '<leader>gg', ':Git<cr>'          , opts)
vim.api.nvim_set_keymap('n', '<leader>ga', ':Git add .<cr>'    , opts)
vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit<cr>'   , opts)
vim.api.nvim_set_keymap('n', '<leader>gp', ':Git push<cr>'     , opts)
vim.api.nvim_set_keymap('n', '<leader>gb', ':Git blame<cr>'    , opts)
vim.api.nvim_set_keymap('n', '<leader>gD', ':Git difftool<cr>' , opts)
vim.api.nvim_set_keymap('n', '<leader>gm', ':Git mergetool<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>gh', ':diffget //2<cr>'  , opts)  -- take diff left
vim.api.nvim_set_keymap('n', '<leader>gl', ':diffget //3<cr>'  , opts)  -- take diff right

-- Diffview.nvim
vim.api.nvim_set_keymap('n', '<leader>gd', ':DiffviewOpen<cr>'       , opts)
vim.api.nvim_set_keymap('n', '<leader>gx', ':DiffviewClose<cr>'      , opts)
vim.api.nvim_set_keymap('n', '<leader>gr', ':DiffviewRefresh<cr>'    , opts)
vim.api.nvim_set_keymap('n', '<leader>gt', ':DiffviewToggleFiles<cr>', opts)

-- Gitgutter
vim.g.gitgutter_map_keys = 0  -- don't use default key mappings

vim.api.nvim_set_keymap("n", "<leader>gj", ":GitGutterNextHunk<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>gk", ":GitGutterPrevHunk<cr>", opts)

-- Gitlinker
-- NOTE: the extra 'v`<' at the end of the visual commands is used to exit visual mode and return to the top off
-- the visual block.
vim.api.nvim_set_keymap(
    "n",
    "<leader>gi",
    "<cmd>lua require('gitlinker').get_buf_range_url('n')<cr>",
    opts
)
vim.api.nvim_set_keymap(
    "v",
    "<leader>gi",
    "<cmd>lua require('gitlinker').get_buf_range_url('v')<cr>v`<",
    opts
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>go",
    "<cmd>lua require('gitlinker').get_buf_range_url('n', {action_callback = require('gitlinker.actions').open_in_browser})<cr>",
    opts
)
vim.api.nvim_set_keymap(
    "v",
    "<leader>go",
    "<cmd>lua require('gitlinker').get_buf_range_url('v', {action_callback = require('gitlinker.actions').open_in_browser})<cr>v`<",
    opts
)
