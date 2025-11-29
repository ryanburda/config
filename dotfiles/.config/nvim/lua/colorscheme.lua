--[[
Colorscheme Auto-Reload for Neovim

This module watches for changes to the `nvim_colorscheme` environment variable.
This allows all running instances of nvim to update their colorscheme when `set_colorscheme.sh` changes that variable.
--]]

local T = {}
local env = require('env')

local function watch_file_for_changes(filepath, callback)
  local uv = vim.loop
  local fs_event = uv.new_fs_event()

  fs_event:start(filepath, {}, vim.schedule_wrap(function(err, filename, events)
    if err then
      print("Error watching file:", err)
      return
    end

    if filename then
      callback(filename)
    end
  end))
end

function T.set_colorscheme()
  -- Callback function triggered on file change
  vim.cmd('colorscheme ' .. env.envget('nvim_colorscheme', 'everforest'))
  vim.cmd('set background=' .. env.envget('nvim_background', 'dark'))

  if env.envget('wezterm_background', 'NONE') ~= "NONE" then
    -- These highlight groups should be made transparent when displaying a background.
    vim.cmd("highlight Normal guibg=none ctermbg=none")
    vim.cmd("highlight NormalNC guibg=none ctermbg=none")
    vim.cmd("highlight NormalFloat guibg=none ctermbg=none")
    vim.cmd("highlight NonText guibg=none ctermbg=none")
    vim.cmd("highlight NeoTreeNormal guibg=none ctermbg=none")
    vim.cmd("highlight NeoTreeNormalNC guibg=none ctermbg=none")
    vim.cmd("highlight NeoTreeEndOfBuffer guibg=none ctermbg=none")
  end
end

function T.setup()
  -- Set the colorscheme on startup in case it has changed since the last time nvim ran.
  T.set_colorscheme()
  -- Update the colorscheme when the `nvim_colorscheme` environment variable changes.
  watch_file_for_changes(env.envpath('nvim_colorscheme'), T.set_colorscheme)
end

return T
