local cache = {
  git_diff = '',
  tabs = '',
  buf_mark = '',
}

local function update_git_diff()
  local added, removed, untracked = 0, 0, 0

  local handle = io.popen('git diff --numstat HEAD 2>/dev/null')
  if handle then
    local result = handle:read('*a')
    handle:close()
    for a, r in result:gmatch('(%d+)%s+(%d+)%s+[^\n]+') do
      added = added + tonumber(a)
      removed = removed + tonumber(r)
    end
  end

  handle = io.popen('git ls-files --others --exclude-standard 2>/dev/null')
  if handle then
    for _ in handle:lines() do
      untracked = untracked + 1
    end
    handle:close()
  end

  local parts = {}
  if added > 0 then table.insert(parts, string.format('%%#diffAdded#+%d%%*', added)) end
  if removed > 0 then table.insert(parts, string.format('%%#diffRemoved#-%d%%*', removed)) end
  if untracked > 0 then table.insert(parts, string.format('%%#diffChanged#?%d%%*', untracked)) end
  cache.git_diff = table.concat(parts, ' ')
  vim.cmd('redrawstatus')
end

local function update_tabs()
  local current = vim.fn.tabpagenr()
  local total = vim.fn.tabpagenr('$')
  local parts = {}
  for i = 1, total do
    if i == current then
      table.insert(parts, string.format('%%#CursorLineNr# %d %%*', i))
    else
      table.insert(parts, string.format('%%#LineNr# %d %%*', i))
    end
  end
  cache.tabs = table.concat(parts)
  vim.cmd('redrawstatus')
end

local function update_buf_mark()
  cache.buf_mark = require('buf-mark.status').get()
  vim.cmd('redrawstatus')
end

function Statusline()
  return table.concat({
    ' ', cache.git_diff,
    '%=',
    cache.buf_mark,
    '%=',
    cache.tabs, ' ',
  })
end

vim.o.statusline = '%!v:lua.Statusline()'

-- git diff: startup, buffer write, file create/delete, focus regained
vim.api.nvim_create_autocmd({'BufWritePost', 'BufAdd', 'BufDelete', 'FocusGained'}, {
  callback = update_git_diff,
})

-- tabs: tab add, delete, or switch
vim.api.nvim_create_autocmd({'TabNew', 'TabClosed', 'TabEnter'}, {
  callback = update_tabs,
})

-- buf-mark: buffer open/switch, mark change
vim.api.nvim_create_autocmd({'BufAdd', 'BufEnter'}, {
  callback = update_buf_mark,
})
-- buf-mark: buffer close (deferred so buffer is actually gone)
vim.api.nvim_create_autocmd('BufDelete', {
  callback = function() vim.schedule(update_buf_mark) end,
})
vim.api.nvim_create_autocmd('User', {
  pattern = 'BufMarkChanged',
  callback = update_buf_mark,
})

-- initialize caches on startup
update_git_diff()
update_tabs()
update_buf_mark()
