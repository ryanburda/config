local T = {}

function T.setup()

    vim.g.VtrStripLeadingWhitespace = 0
    vim.g.VtrClearEmptyLines = 0
    vim.g.VtrAppendNewline = 1

    vim.cmd([[
    function! VtrSendLinesToRunnerPSQL() range
        " `q` exists the psql pager if it is up.
        VtrSendKeysRaw q
        " get rid of the `q` if the psql pager wasn't open.
        VtrSendCtrlC
        " clear the screen.
        VtrSendCommandToRunner \! clear
        " send the lines.
        VtrSendLinesToRunner
    endfunction
    ]])

    local opts = { noremap=true, silent=true }

    vim.api.nvim_set_keymap("n", "<leader>ei", ":VtrOpenRunner<cr>"                  , opts)
    vim.api.nvim_set_keymap("n", "<leader>ea", ":VtrAttachToPane<cr>"                , opts)
    vim.api.nvim_set_keymap("x", "<leader>ee", ":call VtrSendLinesToRunnerPSQL()<cr>", opts)
    vim.api.nvim_set_keymap("n", "<leader>ef", ":VtrSendFile<cr>"                    , opts)

end

return T
