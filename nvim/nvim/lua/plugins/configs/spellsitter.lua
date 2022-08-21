local T = {}

function T.setup()

    require('spellsitter').setup()

    local augroup = vim.api.nvim_create_augroup("SpellSitter", { clear = true })

    vim.api.nvim_create_autocmd("VimEnter", {
        command = "highlight! SpellBad guisp=red gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=undercurl cterm=undercurl",
        group = augroup
    })

    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "Outline", "NvimTree", }, -- disable spellchecking for these filetypes. Run `:echo &ft` to get the type of a file
        command = "setlocal nospell",
        group = augroup,
    })

    vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*", -- disable spellchecking in the embedded terminal
        command = "setlocal nospell",
        group = augroup,
    })

end

return T
