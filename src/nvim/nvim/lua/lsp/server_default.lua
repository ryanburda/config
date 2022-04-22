local opts = { noremap=true, silent=false}

local on_attach = function(client, bufnr)
    -- function that should be called when setting up all LSPs.

    -- mappings. See `:help vim.lsp.*` for documentation on any of the below functions.
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>j', '<cmd>lua vim.lsp.buf.definition()<CR>'    , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>'         , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-k>'    , '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

    -- show signature help using the ray-x/lsp_signature.nvim plugin
    require("lsp_signature").on_attach()
end

local config = {
    on_attach = on_attach
}

return config
