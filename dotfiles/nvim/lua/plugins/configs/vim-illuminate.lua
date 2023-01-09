local T = {}

function T.setup()

    local augroup = vim.api.nvim_create_augroup("VimIlluminate", { clear = true })
    vim.api.nvim_create_autocmd("VimEnter", { command = "highlight! link IlluminatedWordText CursorLine", group = augroup })
    vim.api.nvim_create_autocmd("VimEnter", { command = "highlight! link IlluminatedWordRead CursorLine", group = augroup })
    vim.api.nvim_create_autocmd("VimEnter", { command = "highlight! link IlluminatedWordWrite CursorLine", group = augroup })

    require('illuminate').configure()

end

return T

