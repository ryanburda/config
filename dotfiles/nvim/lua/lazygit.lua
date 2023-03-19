local T = {}

-- open lf file manager in tmux popup
T.open = function()
    io.popen("tmux popup -e NVIM_PIPE=$NVIM_PIPE -h 85\\% -w 85\\% -E 'lazygit'")
end

T.keymaps = function ()
    -- Open lazygit
    vim.keymap.set({'n', 'v', 'i', 'x'}, '<M-7>', function () T.open() end)
end

return T
