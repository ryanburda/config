local T = {}

T.lsp_signature = require('lsp_signature')

T.capabilities = vim.lsp.protocol.make_client_capabilities()
T.capabilities = require('cmp_nvim_lsp').default_capabilities(T.capabilities)

function T.setup_keymaps(bufnr)
    -- mappings. See `:help vim.lsp.*` for documentation on any of the below functions.
    local opts = { noremap=true, silent=false}
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jj', '<cmd>lua vim.lsp.buf.definition()<CR>'     , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jh', '<cmd>lua vim.lsp.buf.hover()<CR>'          , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jk', '<cmd>lua vim.lsp.buf.references()<CR>'     , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ja', '<cmd>lua vim.lsp.buf.code_action()<CR>'    , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jr', '<cmd>lua vim.lsp.buf.rename()<CR>'         , opts)
end

function T.on_attach(_, bufnr)
    T.setup_keymaps(bufnr)

    -- show signature help using the ray-x/lsp_signature.nvim plugin
    T.lsp_signature.on_attach()
end

-- Setup the config
T.config = {
    on_attach = T.on_attach,
    capabilities = T.capabilities,
}

return T
