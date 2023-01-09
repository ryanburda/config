local T = {}

T.capabilities = vim.lsp.protocol.make_client_capabilities()
T.capabilities = require('cmp_nvim_lsp').default_capabilities(T.capabilities)

function T.on_attach(_, bufnr)
    local opts = { noremap=true, silent=false}
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'H', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jj', '<cmd>lua vim.lsp.buf.definition()<CR>'     , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jk', '<cmd>lua vim.lsp.buf.references()<CR>'     , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ja', '<cmd>lua vim.lsp.buf.code_action()<CR>'    , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jr', '<cmd>lua vim.lsp.buf.rename()<CR>'         , opts)
end

-- Setup the config
T.config = {
    on_attach = T.on_attach,
    capabilities = T.capabilities,
}

return T
