local T = {}

T.toggle = function()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_exists = true
        end
    end
    if qf_exists == true then
        vim.cmd "cclose"
        return
    end
    vim.cmd "copen"
end

T.open_all = function ()
    if vim.tbl_isempty(vim.fn.getqflist()) then
        return
    end
    local prev_val = ""
    for _, d in ipairs(vim.fn.getqflist()) do
        local curr_val = vim.fn.bufname(d.bufnr)
        if curr_val ~= prev_val then
            vim.cmd("edit " .. curr_val)
        end
        prev_val = curr_val
    end
end

T.keymaps = function ()
    vim.keymap.set('n', '<leader>kk' , T.toggle, {desc = "Quickfix toggle"})
    vim.keymap.set('n', '<leader>ka' , T.open_all, {desc = "Quickfix open all files"})
    vim.keymap.set('n', '<leader>kn' , ':cnext<CR>', {desc = "Quickfix next"})
    vim.keymap.set('n', '<leader>kp' , ':cprev<CR>', {desc = "Quickfix previous"})
    vim.keymap.set('n', '<leader>kgg', ':cfirst<CR>', {desc = "Quickfix first"})
    vim.keymap.set('n', '<leader>kG' , ':clast<CR>', {desc = "Quickfix last"})
    vim.keymap.set('n', '<leader>kc' , ':cexpr []<CR>', {desc = "Quickfix clear"})
end

return T
