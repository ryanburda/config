local config = require('lsp.server_default')

config.settings = {
    yaml = {
        schemas = {
            ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.y*ml",
            ["https://json.schemastore.org/drone.json"] = ".drone.y*ml",
        }
    }
}

return config
