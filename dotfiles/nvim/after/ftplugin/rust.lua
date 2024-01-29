local bufnr = vim.api.nvim_get_current_buf()

-- mrcjkb/rustaceanvim automatically detects codelldb installations.
-- In this case codelldb should be installed from Mason.
-- See: https://github.com/mrcjkb/rustaceanvim?tab=readme-ov-file#using-codelldb-for-debugging
vim.keymap.set(
    "n",
    "<M-d>",
    function()
        vim.cmd.RustLsp('debuggables')
    end,
    { buffer = bufnr }
)

vim.keymap.set(
    "n",
    "<M-r>",
    function()
        vim.cmd.RustLsp('runnables')
    end,
    { buffer = bufnr }
)
