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

function T.get_background_config(image_path, color, opacity)
    -- Returns a lua table with the configuration for `config.background`.
    -- This function is intended to provide the following combinations based on the inputs that are passed in:
    --     - standard background. (empty config)
    --     - background image only.
    --     - transparent color only.
    --     - combination of background image with transparent color layer on top.
    --
    -- Args:
    -- image_path: path to the background image, or `nil`.
    -- color: color of layer on top of image, or `nil`.
    -- opacity: opacity of color layer (0.0 - 1.0), or `nil`.

    local background_config = {}

    -- Lay the image down first if one was selected.
    if image_path ~= nil then
        table.insert(
            background_config,
            {
                source = {
                    File = image_path
                },
            }
        )
    end

    -- Add the color layer if one was selected.
    if color ~= nil then
        table.insert(
            background_config,
            {
                source = {
                    Color = color
                },
                opacity = opacity,
                -- height and width needed due to https://github.com/wez/wezterm/issues/2817
                height = '100%',
                width = '100%',
            }
        )
    end

    return background_config

end

return T
