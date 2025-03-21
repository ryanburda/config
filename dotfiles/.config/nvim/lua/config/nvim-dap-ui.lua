local T = {}

function T.setup()

  local dap = require('dap')
  local dapui = require('dapui')

  dapui.setup()
  dap.listeners.after.event_initialized['dapui_config'] = function () dapui.open() end

end

return T
