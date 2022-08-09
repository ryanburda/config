local T = {}
T.default = require('lsp.server_default')
T.config = T.default.config

function T.on_attach(client, bufnr)
    T.default.on_attach(client, bufnr)

    -- Add rust specific keymaps here.
    --local opts = { noremap=true, silent=true }
    --vim.api.nvim_set_keymap('n', '<leader>uu', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
end

T.config = {}
T.config.on_attach = T.on_attach

return T

