-----------------
-- Status line --
-----------------
-- The Statusline() function is called on every redraw, so it must be cheap.
-- Each component pre-computes its string into `cache` and only updates it
-- in response to specific autocommands. Statusline() simply concatenates
-- cached values without doing any work itself.

local cache = {
  tabs = '',
  buf_mark = '',
  git_diff = '',
}

local function update_cache(key, value)
  -- redraw the status line after each cache update
  cache[key] = value
  vim.cmd('redrawstatus')
end

function Statusline()
  -- Git diff on left, buf-marks in center, tabs on right
  -- `+12 -6              a b c             1 2 3`
  return table.concat({
    '%-24.24(', cache.tabs, ' %)',
    '%=',
    cache.buf_mark,
    '%=',
    '%24.24( ', cache.git_diff, '%)',
  })
end

vim.o.statusline = '%!v:lua.Statusline()'

----------------
-- Components --
----------------
-- Each component below will consist of the following:
--   1) A function that updates the cache
--   2) A call to that function to initialize the cache on startup
--   3) A set of autocmd creations that control when the cache is updated
--
-- This event based approach avoids the timer based polling found in other status line plugins.

-------------------------
-- Git diff component --
-------------------------
-- Shells out to `git diff --numstat` for added/removed line counts and
-- `git ls-files --others` for untracked file counts, then builds a
-- highlighted summary string (e.g. "+3 -1 ?2") into the cache.
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
  if added > 0 then table.insert(parts, string.format('+%d', added)) end
  if removed > 0 then table.insert(parts, string.format('-%d', removed)) end
  if untracked > 0 then table.insert(parts, string.format('?%d', untracked)) end

  local result = '%#LineNr#' .. table.concat(parts, ' ') .. '%*'
  update_cache('git_diff', result)
end

update_git_diff()

vim.api.nvim_create_autocmd({'BufWritePost', 'BufAdd', 'BufDelete', 'FocusGained'}, {
  callback = update_git_diff,
})

------------------------
-- Buf-Mark component --
------------------------
-- Fetches the current buf-mark status string from the buf-mark plugin.
local function update_buf_mark()
  update_cache('buf_mark', require('buf-mark.status').get())
end

update_buf_mark()

vim.api.nvim_create_autocmd({'BufAdd', 'BufEnter'}, {
  callback = update_buf_mark,
})

-- buffer close (deferred so buffer is actually gone)
vim.api.nvim_create_autocmd('BufDelete', {
  callback = function() vim.schedule(update_buf_mark) end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'BufMarkChanged',
  callback = update_buf_mark,
})

--------------------
-- Tabs component --
--------------------
-- Builds a numbered list of tabs, highlighting the current tab with
-- CursorLineNr and the rest with LineNr.
local function update_tabs()
  local current = vim.fn.tabpagenr()
  local total = vim.fn.tabpagenr('$')

  if total == 1 then
    update_cache('tabs', '')
    return
  end

  local parts = {}
  for i = 1, total do
    if i == current then
      table.insert(parts, string.format('%%#CursorLineNr# %d %%*', i))
    else
      table.insert(parts, string.format('%%#LineNr# %d %%*', i))
    end
  end

  update_cache('tabs', table.concat(parts))
end

update_tabs()

vim.api.nvim_create_autocmd({'TabNew', 'TabClosed', 'TabEnter'}, {
  callback = update_tabs,
})
