local T = {}

local nvim_opposite_direction_map = {
  ['h'] = 'j',
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

local function get_tmux_pane_id()
    local handle = io.popen("tmux display-message -p '#{pane_id}' 2>/dev/null")
    local result = handle:read("*a")
    handle:close()
    return result:gsub("%s+", "") -- Trim any trailing whitespace/newline
end

local function get_split_type(direction)
  -- returns either:
  --   nil
  --   nvim
  --   tmux
  -- showing what kind of split is in that direction.
  local current_nvim_winnr = vim.fn.winnr()
  local current_tmux_pane_id = get_tmux_pane_id()

  -- Move that direction in nvim
  vim.cmd(string.format('wincmd %s', direction))

  if current_nvim_winnr ~= vim.fn.winnr() then
    vim.cmd('wincmd p')
    return 'nvim'
  end

  -- Move that direction in tmux
  local handle = io.popen(string.format('tmux select-pane -%s 2>/dev/null', nvim_to_tmux_direction_map[direction]))
  local result = handle:read("*a")
  handle:close()

  if get_tmux_pane_id() ~= current_tmux_pane_id then
    local command = "tmux select-pane -l 2>/dev/null"
    os.execute(command)
    return 'tmux'
  end

  return nil
end

T.tmux_nvim_move = function(direction)
  local split_type = get_split_type(direction)

  if split_type == 'nvim' then
    vim.cmd(string.format('wincmd %s', direction))
  else
    local handle = io.popen(string.format('tmux select-pane -%s 2>/dev/null', nvim_to_tmux_direction_map[direction]))
    local result = handle:read("*a")
    handle:close()
  end

end

T.tmux_nvim_resize = function(direction, amount)

  local direction_str = 'horizontal'
  if direction == 'h' or direction == 'l' then
    direction_str = 'vertical'
  end

  local opposite_direction = nvim_opposite_direction_map[direction]

  local direction_split_type = get_split_type(direction)
  local opposite_direction_split_type = get_split_type(opposite_direction)

  if direction_split_type == 'nvim' then
    vim.cmd(string.format('%s resize +%s', direction_str, amount))
  elseif opposite_direction_split_type == 'nvim' then
    vim.cmd(string.format('%s resize -%s', direction_str, amount))
  elseif direction_split_type == 'tmux' then
    os.execute(string.format("tmux resize-pane -%s %d", nvim_to_tmux_direction_map[direction], amount))
  end

end

return T
