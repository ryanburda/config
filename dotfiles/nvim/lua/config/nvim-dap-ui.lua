local T = {}

function T.setup()

  local dap = require('dap')
  local dapui = require('dapui')

  dapui.setup({
    expand_lines = true,
    layouts = {
      {
        elements = {
          { id = "watches", size = 0.25 },
          { id = "stacks", size = 0.25 },
          { id = "console", size = 0.25 },
          { id = "repl", size = 0.25 },
        },
        size = 65, -- # of columns
        position = "right",
      },
      {
        elements = {
          { id = "scopes", size = 1.0 },
        },
        size = 12, -- # of rows
        position = "bottom",
      },
    },
  })

  dap.listeners.after.event_initialized['dapui_config'] = function () dapui.open() end

end

return T
