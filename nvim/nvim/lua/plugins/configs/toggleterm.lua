local T = {}

function T.setup()

    require("toggleterm").setup({
        direction = 'float',
    })

    local opts = { noremap=true, silent=false}
    vim.api.nvim_set_keymap('n', '<leader>tt', ":ToggleTerm<cr>", opts)

    -- Lazydocker
    local Terminal  = require('toggleterm.terminal').Terminal
    local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float", })

    function _LAZYDOCKER_TOGGLE()
        lazydocker:toggle()
    end

    vim.api.nvim_set_keymap("n", "<leader>cc", "<cmd>lua _LAZYDOCKER_TOGGLE()<CR>", opts)

end

return T
