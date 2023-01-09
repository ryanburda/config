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


    -- Lazydocker
    local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float", })
    function _LAZYDOCKER_TOGGLE()
        lazydocker:toggle()
    end
    vim.api.nvim_set_keymap("n", "<leader>cc", "<cmd>lua _LAZYDOCKER_TOGGLE()<CR>", opts)

    -- -- Lazykube
    -- local lazykube = Terminal:new({ cmd = "lazykube", hidden = true, direction = "float", })
    -- function _LAZYKUBE_TOGGLE()
    --     lazykube:toggle()
    -- end
    -- vim.api.nvim_set_keymap("n", "<leader>k8", "<cmd>lua _LAZYKUBE_TOGGLE()<CR>", opts)

    -- K9
    local k9 = Terminal:new({ cmd = "k9s", hidden = true, direction = "float", })
    function _K9_TOGGLE()
        k9:toggle()
    end
    vim.api.nvim_set_keymap("n", "<leader>k8", "<cmd>lua _K9_TOGGLE()<CR>", opts)


end

return T
