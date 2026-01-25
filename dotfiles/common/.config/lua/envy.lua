local M = {}

M.DIR = (os.getenv('XDG_CONFIG_HOME') or os.getenv('HOME') .. '/.config') .. '/.envy'

function M.path(name)
  return M.DIR .. '/' .. name
end

function M.get(name, default)
  local file = io.open(M.path(name), 'r')
  if not file then
    return default or ''
  end
  local content = file:read('*a'):gsub('%s+$', '')
  file:close()
  return content
end

function M.set(name, value)
  local file = io.open(M.path(name), 'w')
  if file then
    file:write(value)
    file:close()
  end
end

function M.rm(name)
  os.remove(M.path(name))
end

function M.ls()
  local handle = io.popen('ls "' .. M.DIR .. '"')
  if not handle then
    return {}
  end
  local result = handle:read('*a')
  handle:close()

  local files = {}
  for file in result:gmatch('[^\n]+') do
    table.insert(files, file)
  end
  return files
end

return M
