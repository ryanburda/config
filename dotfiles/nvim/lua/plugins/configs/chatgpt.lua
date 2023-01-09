local T = {}

function T.setup()

    require("chatgpt").setup({
        welcome_message = ""
    })

    local opts = { noremap=true, silent=false }
    vim.keymap.set("n", "<leader>cb", ':ChatGPT<CR>', opts)

end

return T
