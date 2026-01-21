-- TODO: move this out of Wezterm folder.
local T = {}

-- TODO: remove hardcode, use ENV_DIR
T.ENV_DIR = os.getenv("HOME") .. '/.config/.env'

function T.envset(filename, content)
    local filePath = T.ENV_DIR .. "/" .. filename

    -- Open the file for writing
    local file, err = io.open(filePath, "w")
    if not file then
        error("Could not open file for writing: " .. err)
    end

    -- Write the content to the file
    file:write(content)
    file:close()
end

function T.envget(filename, defaultValue)
    local filePath = T.ENV_DIR .. "/" .. filename

    -- Check if the file exists
    local file = io.open(filePath, "r")
    if file then
        local content = file:read("*a"):gsub("%s*$", "")
        file:close()
        return content
    else
        -- File does not exist, return the default value
        return defaultValue
    end
end

return T
