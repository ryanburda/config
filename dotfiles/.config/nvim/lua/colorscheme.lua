local T = {}

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

T.COLORSCHEME_DEFAULT = 'bamboo'
T.COLORSCHEME_FILE = os.getenv('HOME') .. '/.config/.env/nvim_colorscheme'
T.BACKGROUND_DEFAULT = 'dark'
T.BACKGROUND_FILE = os.getenv('HOME') .. '/.config/.env/nvim_background'

function T.set_colorscheme(is_setup)
  is_setup = is_setup or false

  -- create the colorscheme file if it doesn't already exist
  if io.open(T.COLORSCHEME_FILE, "r") == nil then
    local colorscheme_file = io.open(T.COLORSCHEME_FILE, "w+")
    if colorscheme_file ~= nil then
      colorscheme_file:write(T.COLORSCHEME_DEFAULT)
      colorscheme_file:close()
    else
      print("Error: Could not open colorscheme file for writing.")
    end
  end

  -- create the background file if it doesn't already exist
  if io.open(T.BACKGROUND_FILE, "r") == nil then
    local background_file = io.open(T.BACKGROUND_FILE, "w+")
    if background_file ~= nil then
      background_file:write(T.BACKGROUND_DEFAULT)
      background_file:close()
    else
      print("Error: Could not open colorscheme file for writing.")
    end
  end

  -- read the colorscheme from the colorscheme file
  local colorscheme_file = io.open(T.COLORSCHEME_FILE, "r")
  if colorscheme_file ~= nil then
    local colorscheme = colorscheme_file:read("*a")
    vim.cmd('colorscheme ' .. colorscheme)
    colorscheme_file:close()
  else
    print("Error: Could not read colorscheme file.")
  end

  -- read the background from the background file
  local background_file = io.open(T.BACKGROUND_FILE, "r")
  if background_file ~= nil then
    local background = background_file:read("*a")
    vim.cmd('set background=' .. background)
    background_file:close()
  else
    print("Error: Could not read background file.")
  end

end

local function get_var_from_file(file_path, default)
  -- Reads value from `file_path`, returns `default` if file does not exist.
  local file, _ = io.open(file_path, "r")
  if not file then
    -- Could not open file
    return default
  end

  local content = file:read("*a")

  -- Remove trailing new lines
  content = content:gsub("%s*$", "")

  file:close()
  return content
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

function T.set_transparent_background_conditional()
  -- Read the .background file
  local background = get_var_from_file(os.getenv("HOME") .. "/.config/wezterm/.background", "NONE")

  if background ~= "NONE" then
    T.set_transparent_background()
  end
end

function T.setup()
  -- Autocommand to make specific highlight groups transparent when an background image is being shown.
  -- This will run automatically whenever the colorscheme changes.
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = T.set_transparent_background_conditional
  })

  T.set_colorscheme(true)

  -- update the colorscheme when the colorscheme file changes.
  watch_file_for_changes(T.COLORSCHEME_FILE, function()
    -- Callback function triggered on file change
    T.set_colorscheme(true)
  end)

end

return T
