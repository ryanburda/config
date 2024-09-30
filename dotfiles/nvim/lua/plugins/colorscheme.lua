-- Colorschemes are meant to be changed with the `dotfiles/funcs/theme_picker` function.
-- That function synchronizes the terminal and neovim colorschemes while also persisting
-- the current colorscheme/background to files.
local COLORSCHEME_DEFAULT = 'everforest'
local COLORSCHEME_FILE = vim.fn.stdpath('config') .. '/.colorscheme'
local BACKGROUND_DEFAULT = 'dark'
local BACKGROUND_FILE = vim.fn.stdpath('config') .. '/.background'

local function set_colorscheme(is_setup)
    is_setup = is_setup or false

    -- create the colorscheme file if it doesn't already exist
    if io.open(COLORSCHEME_FILE, "r") == nil then
        local colorscheme_file = io.open(COLORSCHEME_FILE, "w+")
        if colorscheme_file ~= nil then
            colorscheme_file:write(COLORSCHEME_DEFAULT)
            colorscheme_file:close()
        else
            print("Error: Could not open colorscheme file for writing.")
        end
    end

    -- create the background file if it doesn't already exist
    if io.open(BACKGROUND_FILE, "r") == nil then
        local background_file = io.open(BACKGROUND_FILE, "w+")
        if background_file ~= nil then
            background_file:write(BACKGROUND_DEFAULT)
            background_file:close()
        else
            print("Error: Could not open colorscheme file for writing.")
        end
    end

    -- read the colorscheme from the colorscheme file
    local colorscheme_file = io.open(COLORSCHEME_FILE, "r")
    if colorscheme_file ~= nil then
        local colorscheme = colorscheme_file:read("*a")
        vim.cmd('colorscheme ' .. colorscheme)
        colorscheme_file:close()
    else
        print("Error: Could not read colorscheme file.")
    end

    -- read the background from the background file
    local background_file = io.open(BACKGROUND_FILE, "r")
    if background_file ~= nil then
        local background = background_file:read("*a")
        vim.cmd('set background=' .. background)
        background_file:close()
    else
        print("Error: Could not read background file.")
    end

    -- Don't reload the colorizer plugin if neovim is just starting up.
    if is_setup == false then
        -- Reload colorizer plugin.
        -- NOTE: must refresh the current buffer manually (`:e`)
        vim.cmd('silent Lazy reload nvim-colorizer.lua')
    end

end

local function set_transparent_background()
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

    -- Colorscheme specific highlight group changes
    -- TODO: figure out why the current colorscheme is being printed when neovim starts.
    -- local colorscheme = vim.cmd('colorscheme')
    -- if colorscheme == "gruvbox-material" then
    --     vim.cmd("highlight NeoTreeNormal guibg=none ctermbg=none")
    --     vim.cmd("highlight NeoTreeNormalNC guibg=none ctermbg=none")
    -- elseif colorscheme == "bamboo" then
    --     vim.cmd("highlight NeoTreeNormal guibg=none ctermbg=none")
    --     vim.cmd("highlight NeoTreeNormalNC guibg=none ctermbg=none")
    -- elseif colorscheme == "everforest" then
    --     vim.cmd("highlight NeoTreeNormal guibg=none ctermbg=none")
    --     vim.cmd("highlight NeoTreeNormalNC guibg=none ctermbg=none")
    -- end
end

local function set_transparent_background_conditional()
    -- Sets specific highlight groups to be transparent based on whether a background
    -- image file exists. If no file exists then highlight groups should appear normally.

    -- Read the .background file
    local file, _ = io.open(os.getenv("HOME") .. "/.config/wezterm/.background", "r")

    -- Only make highlight groups transparent if the .background file exists.
    -- If the .background file doesn't exist then a background image is not
    -- being shown and colors should show up normally.
    if file then
        set_transparent_background()
    end
end

-- Autocommand to make specific highlight groups transparent when an background image is being shown.
-- This will run automatically whenever the colorscheme changes.
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = set_transparent_background_conditional
})

return {
    "rktjmp/fwatch.nvim",
    dependencies = {
        "sainnhe/everforest",
        "sainnhe/gruvbox-material",
        "rebelot/kanagawa.nvim",
        "EdenEast/nightfox.nvim",
        "Verf/deepwhite.nvim",
        "Mofiqul/vscode.nvim",
        "ribru17/bamboo.nvim",
        "sho-87/kanagawa-paper.nvim",
        "shaunsingh/nord.nvim",
        {
            "yorik1984/newpaper.nvim",
            config = true,
        },
        {
            "zenbones-theme/zenbones.nvim",
            dependencies = {
                "rktjmp/lush.nvim",
            },
        },
    },
    config = function()
        set_colorscheme(true)
        set_transparent_background_conditional()

        -- update the colorscheme when the colorscheme file changes.
        local fwatch = require('fwatch')
        fwatch.watch(COLORSCHEME_FILE, {
            on_event = function()
                -- sleep for a bit to make sure the background file is done being written to as well.
                vim.schedule(function() vim.defer_fn(set_colorscheme, 100) end)
            end
        })
    end
}
