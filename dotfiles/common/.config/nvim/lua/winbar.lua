-------------
-- Win bar --
-------------
-- The Winbar() function is called on every redraw, so it must be cheap.
-- Each component pre-computes its string into `cache` and only updates it
-- in response to specific autocommands. Winbar() simply concatenates
-- cached values without doing any work itself.

local cache = {
  diagnostics = '',
}

local function update_cache(key, value)
  cache[key] = value
  vim.cmd('redrawstatus')
end

function Winbar()
  local is_active = vim.g.statusline_winid == vim.api.nvim_get_current_win()

  -- Show the modified bit or whitespace so that the file name doesn't move when the file is modified
  local winid = vim.g.statusline_winid or vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_win_get_buf(winid)
  local modified = vim.bo[bufnr].modified and '[+]' or '   '

  local file_hl = is_active and '%#CursorLineNr#' or '%#LineNr#'

  return table.concat({
    '   %#LineNr#%4l:%-3c%*',
    '%=',
    file_hl, '%f ', modified, '%*',
    '%=',
    ' ', is_active and cache.diagnostics or '',
    '%#LineNr#%3p%%%* ',
  })
end

vim.o.winbar = '%!v:lua.Winbar()'

----------------
-- Components --
----------------
-- Each component below will consist of the following:
--   1) A function that updates the cache
--   2) A call to that function to initialize the cache on startup
--   3) A set of autocmd creations that control when the cache is updated
--
-- This event based approach avoids the timer based polling found in other status line plugins.

---------------------------
-- Diagnostics component --
---------------------------
-- Shows LSP diagnostic counts for the current buffer (e.g. "E:2 W:1")
-- using the built-in Diagnostic highlight groups.
local severity = vim.diagnostic.severity

local function update_diagnostics()
  local counts = vim.diagnostic.count(0)
  local parts = {}
  if (counts[severity.ERROR] or 0) > 0 then table.insert(parts, string.format('%%#DiagnosticError#E:%d%%*', counts[severity.ERROR])) end
  if (counts[severity.WARN] or 0) > 0 then table.insert(parts, string.format('%%#DiagnosticWarn#W:%d%%*', counts[severity.WARN])) end
  if (counts[severity.INFO] or 0) > 0 then table.insert(parts, string.format('%%#DiagnosticInfo#I:%d%%*', counts[severity.INFO])) end
  if (counts[severity.HINT] or 0) > 0 then table.insert(parts, string.format('%%#DiagnosticHint#H:%d%%*', counts[severity.HINT])) end
  local result = table.concat(parts, ' ')
  if result ~= '' then result = result .. ' ' end
  update_cache('diagnostics', result)
end

update_diagnostics()

vim.api.nvim_create_autocmd({'DiagnosticChanged', 'BufEnter'}, {
  callback = update_diagnostics,
})
