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
  local winid = vim.g.statusline_winid or 0
  local is_active = winid == vim.api.nvim_get_current_win()
  local file_hl = is_active and '%#CursorLineNr#' or '%#LineNr#'

  local info = vim.fn.getwininfo(winid)[1]
  local lnum_width = math.max(1, info and (info.textoff - 1) or 4)

  --  row/column position and file name with modified bit on left, diagnostics and file progress percentage on right
  --  `5:16  init.lua                                                           W:1 E:2  24%`
  return table.concat({
    -- left
    '%#LineNr#%', tostring(lnum_width), 'l:%-3c', ' %3p%% ',
    -- right
    '%=%m %t'
  })
end

vim.o.winbar = '%!v:lua.Winbar()'
