local M = {}

function M.get_tabline_content()
  local s = ''

  -- Right-align the tab numbers
  s = s .. '%#TabLine#%='

  -- Show tab numbers
  for i = 1, vim.fn.tabpagenr('$') do
    if i == vim.fn.tabpagenr() then
      s = s .. '%#TabLineSel#'
    else
      s = s .. '%#TabLine#'
    end
    s = s .. ' ' .. i .. ' '
  end

  s = s .. '%#TabLineFill#'
  return s
end

return M