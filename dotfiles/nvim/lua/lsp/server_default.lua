local T = {}

T.capabilities = vim.lsp.protocol.make_client_capabilities()
T.capabilities = require('cmp_nvim_lsp').default_capabilities(T.capabilities)

function T.on_attach(_, bufnr)
    vim.keymap.set('n', '<leader>jh', '<cmd>lua vim.lsp.buf.hover()<CR>', {desc = 'LSP Hover', buffer = bufnr})
    vim.keymap.set('n', '<leader>jd', '<cmd>lua vim.lsp.buf.definition()<CR>', {desc = 'LSP jump to definition', buffer = bufnr})
    vim.keymap.set('n', '<leader>jt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {desc = 'LSP jump to type', buffer = bufnr})
    vim.keymap.set('n', '<leader>jk', '<cmd>lua vim.lsp.buf.references()<CR>', {desc = 'LSP references kwickfix', buffer = bufnr})
    vim.keymap.set('n', '<leader>ja', '<cmd>lua vim.lsp.buf.code_action()<CR>', {desc = 'LSP code action', buffer = bufnr})
    vim.keymap.set('n', '<leader>jr', '<cmd>lua vim.lsp.buf.rename()<CR>', {desc = 'LSP rename', buffer = bufnr})
end

-- Setup the config
T.config = {
    on_attach = T.on_attach,
    capabilities = T.capabilities,
}

return T
