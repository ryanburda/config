-- NOTE: This is needed because it isn't possible to get the current file name from `nvim --server pipe --remote-expr`
--       Ideally this will eventually go away leaving only the portion that is in tmux.conf
local T = {}

-- open lf file manager in tmux popup
T.open = function(path)
    io.popen("tmux popup -e NVIM_PIPE=$NVIM_PIPE -h 85\\% -w 85\\% -E 'lf " .. vim.fn.expand(path) .. "'")
end

T.keymaps = function ()
    -- Open lf to the current file
    vim.keymap.set({'n', 'v', 'i', 'x'}, '<M-8>', function () T.open("%") end)
    -- Open lf to the current working directory
    vim.keymap.set({'n', 'v', 'i', 'x'}, '<M-9>', function () T.open("") end)
end

return T
