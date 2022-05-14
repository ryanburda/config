local on_attach = function(client, bufnr)
    -- mappings. See `:help vim.lsp.*` for documentation on any of the below functions.
    local opts = { noremap=true, silent=false}
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>j', '<cmd>lua vim.lsp.buf.definition()<CR>'     , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>J', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>'          , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>' , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>R', '<cmd>lua vim.lsp.buf.rename()<CR>'         , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-k>'    , '<cmd>lua vim.lsp.buf.signature_help()<CR>' , opts)

    -- show signature help using the ray-x/lsp_signature.nvim plugin
    require('lsp_signature').on_attach()

    -- lsp info in status line
    require('lsp-status').on_attach(client)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities = vim.tbl_extend('keep', capabilities or {}, require('lsp-status').capabilities)

local config = {
    on_attach = on_attach,
    capabilities = capabilities,
}

return config
