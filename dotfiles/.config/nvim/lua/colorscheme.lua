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
    -- You might want to add logic here to handle specific types of events
    -- local eventRename = not not string.match(events, 'rename')
    -- local eventChange = not not string.match(events, 'change')
    if filename then
      callback(filename)
    end
  end))
end

function T.set_colorscheme()
  vim.cmd('colorscheme ' .. env.envget('nvim_colorscheme', 'everforest'))
  vim.cmd('set background=' .. env.getenv('background', 'dark'))
end

function T.set_transparent_background()
  -- This function makes specific highlight groups transparent on a per colorscheme basis.
  -- It is therefore important to make sure the terminal neovim is running in has a
  -- background color that looks good with the current colorscheme.
  --
  -- If colors look bad you likely want to change the wezterm background colors.
  -- If things are not transparent that should be then you likely want to add
  -- additional highlight groups below.

  -- These highlight groups should be made transparent for all colorschemes.
  vim.cmd("highlight Normal guibg=none ctermbg=none")
  vim.cmd("highlight NormalNC guibg=none ctermbg=none")
  vim.cmd("highlight NormalFloat guibg=none ctermbg=none")
  vim.cmd("highlight NonText guibg=none ctermbg=none")
  vim.cmd("highlight NeoTreeNormal guibg=none ctermbg=none")
  vim.cmd("highlight NeoTreeNormalNC guibg=none ctermbg=none")
  vim.cmd("highlight NeoTreeEndOfBuffer guibg=none ctermbg=none")

  -- Colorscheme specific highlight group changes
  -- local colorscheme = vim.g.colors_name
  -- if colorscheme == "adwaita" then
  --     vim.cmd("highlight NeoTreeNormal guibg=none ctermbg=none")
  --     vim.cmd("highlight NeoTreeNormalNC guibg=none ctermbg=none")
  --     vim.cmd("highlight NeoTreeEndOfBuffer guibg=none ctermbg=none")
  -- elseif colorscheme == "gruvbox-material" then
  --     vim.cmd("highlight NeoTreeNormal guibg=none ctermbg=none")
  --     vim.cmd("highlight NeoTreeNormalNC guibg=none ctermbg=none")
  --     vim.cmd("highlight NeoTreeEndOfBuffer guibg=none ctermbg=none")
  -- end
end

function T.setup()
  -- Autocommand to make specific highlight groups transparent when an background image is being shown.
  -- This will run automatically whenever the colorscheme changes.
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      if env.envget('wezterm_background', 'NONE') ~= "NONE" then
        T.set_transparent_background()
      end
    end
  })

  T.set_colorscheme()

  -- update the colorscheme when the colorscheme file changes.
  watch_file_for_changes(env.envpath('nvim_colorscheme'), function()
    -- Callback function triggered on file change
    T.set_colorscheme()
  end)

end

return T
