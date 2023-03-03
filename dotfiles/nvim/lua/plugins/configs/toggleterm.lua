local T = {}

function T.setup()

    require("toggleterm").setup({
        direction = 'float',
    })

    local opts = { noremap=true, silent=false}
    vim.api.nvim_set_keymap('n', '<leader>tt', ":ToggleTerm<cr>", opts)

    local Terminal  = require('toggleterm.terminal').Terminal

    -- Lazygit
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float", })
    function _LAZYGIT_TOGGLE()
        lazygit:toggle()
    end
    vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

end

return T
