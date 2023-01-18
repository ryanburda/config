local T = {}

function T.setup()
    require("mason").setup()

    local opts = { noremap=true, silent=false}
    vim.api.nvim_set_keymap('n', '<leader>~', ':Mason<cr>', opts)
end

function T.install_daps()
    local daps = { 'codelldb', 'debugpy', }

    for _, dap in ipairs(daps) do
        vim.cmd('MasonInstall ' .. dap)
    end
end

return T
