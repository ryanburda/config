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
    local colorscheme = vim.cmd('colorscheme')
    if colorscheme == "gruvbox-material" then
        vim.cmd("highlight NeoTreeNormal guibg=none ctermbg=none")
        vim.cmd("highlight NeoTreeNormalNC guibg=none ctermbg=none")
    elseif colorscheme == "bamboo" then
        vim.cmd("highlight NeoTreeNormal guibg=none ctermbg=none")
        vim.cmd("highlight NeoTreeNormalNC guibg=none ctermbg=none")
    elseif colorscheme == "everforest" then
        vim.cmd("highlight NeoTreeNormal guibg=none ctermbg=none")
        vim.cmd("highlight NeoTreeNormalNC guibg=none ctermbg=none")
    end
end

local function set_transparent_background_conditional()
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

-- Run this when vim starts.
set_transparent_background_conditional()
