local T = {}

function T.setup()

    require('devcontainer').setup({
        autocommands = {
            -- can be set to true to automatically start containers when devcontainer.json is available
            init = false,
            -- can be set to true to automatically remove any started containers and any built images when exiting vim
            clean = false,
            -- can be set to true to automatically restart containers when devcontainer.json file is updated
            update = false,
        },
    })

end

return T



