-------------
-- Win bar --
-------------
-- The Winbar() function is called on every redraw, so it must be cheap.

function Winbar()
  local winid = vim.g.statusline_winid or 0

  local info = vim.fn.getwininfo(winid)[1]
  local lnum_width = math.max(1, info and (info.textoff - 1) or 4)

  --  row/column position and file progress percentage on left, modified bit and file name on right.
  --  `5:16  24%                                                                       [+] init.lua`
  return table.concat({
    -- left
    '%#LineNr#%', tostring(lnum_width), 'l:%-3c', ' %3p%% ',
    -- right
    '%=%m %t'
  })
end

vim.o.winbar = '%!v:lua.Winbar()'
