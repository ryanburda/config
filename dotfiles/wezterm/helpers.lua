local T = {}

function T.get_var_from_file(file_path, default)
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

return T
