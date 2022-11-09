local T = {}

function T.setup()

    local opts = { noremap=true, silent=false}

    vim.api.nvim_set_keymap(
        'n',
        '<leader>0',
        '<CMD>lua require("close_buffers").delete({type = "hidden"})<CR>',
        opts
    )

end

return T
