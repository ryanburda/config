local M = {}

function M.get_tabline_content()
  local s = ''

  -- Add marked buffers info
  local marks = require('buf-mark').marks or {}
  local current_buf = vim.api.nvim_buf_get_name(0)

  -- Get list of all open buffers
  local open_buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      open_buffers[vim.api.nvim_buf_get_name(buf)] = true
    end
  end

  -- Collect all buffer paths that will be shown (use set to avoid duplicates)
  local buffers_to_show_set = {}
  for _, bufpath in pairs(marks) do
    if open_buffers[bufpath] then
      buffers_to_show_set[bufpath] = true
    end
  end
  if current_buf ~= '' then
    buffers_to_show_set[current_buf] = true
  end

  local buffers_to_show = {}
  for bufpath, _ in pairs(buffers_to_show_set) do
    table.insert(buffers_to_show, bufpath)
  end

  -- Generate unique names for buffers
  local unique_names = {}
  local by_leaf = {}

  for _, path in ipairs(buffers_to_show) do
    local leaf = vim.fn.fnamemodify(path, ':t')
    if not by_leaf[leaf] then
      by_leaf[leaf] = {}
    end
    table.insert(by_leaf[leaf], path)
  end

  for leaf, paths in pairs(by_leaf) do
    if #paths == 1 then
      unique_names[paths[1]] = leaf
    else
      for _, path in ipairs(paths) do
        local parent = vim.fn.fnamemodify(path, ':h:t')
        unique_names[path] = parent .. '/' .. leaf
      end
    end
  end

  -- Group buffers by path and collect their marks
  local shown_current = false
  local buffer_marks = {}
  for char, bufpath in pairs(marks) do
    if open_buffers[bufpath] then
      if not buffer_marks[bufpath] then
        buffer_marks[bufpath] = {}
      end
      table.insert(buffer_marks[bufpath], char)
    end
  end

  -- Sort marks for each buffer and create display entries
  local sorted_buffer_entries = {}
  for bufpath, chars in pairs(buffer_marks) do
    table.sort(chars)
    local chars_str = table.concat(chars, '')
    table.insert(sorted_buffer_entries, {chars = chars_str, bufpath = bufpath})
  end
  table.sort(sorted_buffer_entries, function(a, b) return a.chars < b.chars end)

  for _, entry in ipairs(sorted_buffer_entries) do
    local display_name = unique_names[entry.bufpath] or vim.fn.fnamemodify(entry.bufpath, ':t')
    local is_current = (entry.bufpath == current_buf)

    if is_current then
      s = s .. '%#TabLineSel#'
      shown_current = true
    else
      s = s .. '%#TabLine#'
    end

    s = s .. ' ' .. entry.chars .. ':' .. display_name .. ' '
  end

  -- Show current buffer if not already shown
  if not shown_current and current_buf ~= '' then
    local current_display_name = unique_names[current_buf] or vim.fn.fnamemodify(current_buf, ':t')
    s = s .. '%#DiffText#'
    s = s .. ' ' .. current_display_name .. ' '
  end

  return s
end

function M.setup()
  vim.api.nvim_create_autocmd('User', {
    pattern = 'BufMarkChanged',
    callback = function()
      _G.buf_mark_tabline = M.get_tabline_content()
    end,
  })

  vim.api.nvim_create_autocmd('BufEnter', {
    callback = function()
      _G.buf_mark_tabline = M.get_tabline_content()
    end,
  })
end

return M
