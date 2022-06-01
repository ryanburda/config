local T = {}
T.default = require('lsp.server_default')
T.config = T.default.config

-- set up the python debugger
local handle = assert(io.popen("which python"))
local result = handle:read("*all")
handle:close()

require('dap-python').setup(result)

return T


