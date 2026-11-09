-------------
-- Win bar --
-------------
-- The Winbar() function is called on every redraw, so it must be cheap.

function Winbar()
  local winid = vim.g.statusline_winid or 0

  local info = vim.fn.getwininfo(winid)[1]
  local lnum_width = math.max(1, info and (info.textoff - 1) or 4)

  --  row/column position, file name on left and modified bit.
  --  file progress percentage on right.
  --  `5:16  init.lua [+]                                 24%`
  return table.concat({
    -- left
    '%#LineNr#%', tostring(lnum_width), 'l:%-5c', '%t %m',
    -- right
    '%=%3p%%'
  })
end

vim.o.winbar = '%!v:lua.Winbar()'
