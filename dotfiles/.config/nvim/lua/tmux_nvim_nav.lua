local T = {}

local nvim_opposite_direction_map = {
  ['h'] = 'l',
  ['j'] = 'k',
  ['k'] = 'j',
  ['l'] = 'h'
}

local nvim_to_tmux_direction_map = {
  ['h'] = 'L',
  ['j'] = 'D',
  ['k'] = 'U',
  ['l'] = 'R'
}

T.move = function(direction)
  local original_nvim_winnr = vim.fn.winnr()

  -- Try to move in the specified direction
  vim.cmd(string.format('wincmd %s', direction))

  -- Move tmux split if there wasn't a nvim split in that direction
  if vim.fn.winnr() == original_nvim_winnr then
    local handle = io.popen(string.format('tmux select-pane -%s 2>/dev/null', nvim_to_tmux_direction_map[direction]))
    local result = handle:read("*a")
    handle:close()
  end
end

T.resize = function(direction, amount)

  local direction_str = 'horizontal'
  if direction == 'h' or direction == 'l' then
    direction_str = 'vertical'
  end

  -- Get the current window number
  local original_nvim_winnr = vim.fn.winnr()

  -- Move the specified direction in nvim
  vim.cmd(string.format('wincmd %s', direction))

  if original_nvim_winnr ~= vim.fn.winnr() then
    vim.cmd('wincmd p')
    vim.cmd(string.format('%s resize +%d', direction_str, amount))
    return
  end

  -- Move opposite direction in nvim
  vim.cmd(string.format('wincmd %s', nvim_opposite_direction_map[direction]))

  if original_nvim_winnr ~= vim.fn.winnr() then
    vim.cmd('wincmd p')
    vim.cmd(string.format('%s resize -%d', direction_str, amount))
    return
  end

  -- Resize the tmux pane if there isn't a nvim split on either side of the current split.
  os.execute(string.format("tmux resize-pane -%s %d 2>/dev/null", nvim_to_tmux_direction_map[direction], amount))

end

return T
