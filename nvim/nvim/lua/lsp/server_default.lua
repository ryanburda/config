local T = {}

T.lsp_status = require('lsp-status')
T.lsp_signature = require('lsp_signature')

T.capabilities = vim.lsp.protocol.make_client_capabilities()
T.capabilities = require('cmp_nvim_lsp').update_capabilities(T.capabilities)
T.capabilities = vim.tbl_extend('keep', T.capabilities or {}, T.lsp_status.capabilities)

function T.setup_keymaps(bufnr)
    -- mappings. See `:help vim.lsp.*` for documentation on any of the below functions.
    local opts = { noremap=true, silent=false}
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jj', '<cmd>lua vim.lsp.buf.definition()<CR>'     , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jk', '<cmd>lua vim.lsp.buf.hover()<CR>'          , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jo', '<cmd>lua vim.lsp.buf.references()<CR>'     , opts)  -- 'jo' - jump to occurrences
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ha', '<cmd>lua vim.lsp.buf.code_action()<CR>'    , opts)  -- 'h' is diagnostics 'a' for action
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>'         , opts)
end

function T.on_attach(client, bufnr)
    T.setup_keymaps(bufnr)

    -- show signature help using the ray-x/lsp_signature.nvim plugin
    T.lsp_signature.on_attach()

    -- lsp info in status line
    T.lsp_status.on_attach(client)
end

-- Setup the config
T.config = {
    on_attach = T.on_attach,
    capabilities = T.capabilities,
}

return T
