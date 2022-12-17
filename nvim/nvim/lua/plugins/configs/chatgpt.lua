local T = {}

function T.setup()

    require("chatgpt").setup()

    local opts = { noremap=true, silent=false }
    vim.keymap.set("n", "<leader>cb", ':ChatGPT<CR>', opts)

end

return T
