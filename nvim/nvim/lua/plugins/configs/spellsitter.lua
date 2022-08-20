local T = {}

function T.setup()

    require('spellsitter').setup()

    local augroup = vim.api.nvim_create_augroup("SpellSitter", { clear = true })
    vim.api.nvim_create_autocmd("VimEnter", { command = "highlight! SpellBad guisp=red gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=underline", group = augroup })

end

return T
