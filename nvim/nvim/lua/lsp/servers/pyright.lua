local T = {}
T.default = require('lsp.server_default')
T.config = T.default.config

-- set up the python debugger
local handle = assert(io.popen("which python"))
local result = handle:read("*all")
handle:close()

require('dap-python').setup(result)
require('dap-python').test_runner = 'pytest'

function T.on_attach(client, bufnr)

    T.default.on_attach(client, bufnr)

    local opts = { noremap=true, silent=false }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<M-m>', ":lua require('dap-python').test_method()<cr>"    , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<M-c>', ":lua require('dap-python').test_class()<cr>"     , opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<M-s>', ":lua require('dap-python').debug_selection()<cr>", opts)

end

T.config = {}
T.config.on_attach = T.on_attach

return T

