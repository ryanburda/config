local T = {}

function T.setup()

  local is_copilot_on = function()
    if vim.g.is_copilot_on then
      return ""
    else
      return ""
    end
  end

  local sqls_connection = function()
    -- TODO: add a check to see if any buffers are attached to sqls.
    if vim.g.sqls_connection then
      return "  " .. vim.g.sqls_connection
    else
      return ""
    end
  end

  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'auto',
      globalstatus = true,
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = '' },
    },
    extensions = {},
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff'},
      lualine_c = {
        {
          'filename',
          file_status = true,
          path = 1
        },
      },
      lualine_x = { 'diagnostics', sqls_connection, is_copilot_on, },
      lualine_y = { 'filetype', },
      lualine_z = { require('trail_marker.extensions.info').info, 'location', 'progress', },
    },
    tabline = {},
  }

end

return T
