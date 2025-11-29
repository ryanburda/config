local M = {}

M.ENV_DIR = (os.getenv('XDG_CONFIG_HOME') or os.getenv('HOME') .. '/.config') .. '/.env'

function M.envpath(name)
  return M.ENV_DIR .. '/' .. name
end

function M.envget(name, default)
  local file = io.open(M.envpath(name), 'r')
  if not file then
    return default or ''
  end
  local content = file:read('*a'):gsub('%s+$', '')
  file:close()
  return content
end

function M.envset(name, value)
  local file = io.open(M.envpath(name), 'w')
  if file then
    file:write(value)
    file:close()
  end
end

function M.envrm(name)
  os.remove(M.envpath(name))
end

function M.envls()
  local handle = io.popen('ls "' .. M.ENV_DIR .. '"')
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
