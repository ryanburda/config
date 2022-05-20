local T = {}
T.default = require('lsp.server_default')

-- Setup the config
T.config = T.default.config
T.config.settings = {
    yaml = {
        schemas = {
            ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.y*ml",
            ["https://json.schemastore.org/drone.json"] = ".drone.y*ml",
        }
    }
}

return T
