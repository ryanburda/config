-------------
-- Win bar --
-------------
-- The Winbar() function is called on every redraw, so it must be cheap.
-- Each component pre-computes its string into `cache` and only updates it
-- in response to specific autocommands. Winbar() simply concatenates
-- cached values without doing any work itself.

local cache = {
  diagnostics = {},  -- keyed by bufnr
}

function Winbar()
  local is_active = vim.g.statusline_winid == vim.api.nvim_get_current_win()
  local file_hl = is_active and '%#CursorLineNr#' or '%#LineNr#'

  return table.concat({
    '%-24.24(   %#LineNr#%4l:%-4c%p%%%*%)',
    '%=',
    file_hl, '%f',
    '%=',
    '%24.24( ', cache.diagnostics[vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)] or '', ' %#LineNr#%m%* %)',
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
local severity = vim.diagnostic.severity

local function update_diagnostics(bufnr)
  local counts = vim.diagnostic.count(bufnr)
  local parts = {}

  if (counts[severity.ERROR] or 0) > 0 then table.insert(parts, string.format('E:%d', counts[severity.ERROR])) end
  if (counts[severity.WARN] or 0) > 0 then table.insert(parts, string.format('W:%d', counts[severity.WARN])) end
  if (counts[severity.INFO] or 0) > 0 then table.insert(parts, string.format('I:%d', counts[severity.INFO])) end
  if (counts[severity.HINT] or 0) > 0 then table.insert(parts, string.format('H:%d', counts[severity.HINT])) end

  local result = '%#LineNr#' .. table.concat(parts, ' ') .. '%*'
  cache.diagnostics[bufnr] = result
  vim.cmd('redrawstatus')
end

for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
  if vim.api.nvim_buf_is_loaded(bufnr) then
    update_diagnostics(bufnr)
  end
end

vim.api.nvim_create_autocmd('BufWritePost', {
  callback = function(args) update_diagnostics(args.buf) end,
})

vim.api.nvim_create_autocmd('BufDelete', {
  callback = function(args) cache.diagnostics[args.buf] = nil end,
})
