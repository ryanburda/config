local T = {}

function T.setup()

    vim.g.VtrStripLeadingWhitespace = 0
    vim.g.VtrClearEmptyLines = 0
    vim.g.VtrAppendNewline = 0

    vim.cmd([[
    function! VtrSendLinesToRunnerWrapper() range
        if &filetype == 'sql'
            " `q` exists the psql pager if it is up.
            VtrSendKeysRaw q
            " get rid of the `q` if the psql pager wasn't open.
            VtrSendCtrlC
            " clear the screen.
            VtrSendCommandToRunner \! clear
            " send the lines.
            '<,'>VtrSendLinesToRunner
        else
            " send the lines.
            '<,'>VtrSendLinesToRunner
        endif
    endfunction
    ]])

end

return T
