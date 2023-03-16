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
    vim.keymap.set('n', '<leader>kx' , T.toggle)
    vim.keymap.set('n', '<leader>kj' , ':cnext<CR>')
    vim.keymap.set('n', '<leader>kk' , ':cprev<CR>')
    vim.keymap.set('n', '<leader>kgg', ':cfirst<CR>')
    vim.keymap.set('n', '<leader>kG' , ':clast<CR>')
    vim.keymap.set('n', '<leader>ka' , T.open_all)  -- open all files in quickfix list
    vim.keymap.set('n', '<leader>kc' , ':cexpr []<CR>')  -- clear quickfix list
end

return T
