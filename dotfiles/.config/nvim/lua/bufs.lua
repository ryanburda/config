-- `:FzfLua buffers` but shows leaf of path first 
--
-- Example usage
-- ```lua
-- --run setup for autocommands
-- require('bufs').setup()
--
-- -- Create a keymap
-- vim.keymap.set(
--   'n',
--   '<C-f>',
--   require('bufs').buffers,
--   { desc = 'buffers' }
-- )
-- ```
local fzf_utils = require("fzf-lua.utils")

local M = {}

-- Store custom buffer order (list of buf_ids)
M.custom_order = nil

M.get_last_cursor_position = function(bufnr)
  if vim.b[bufnr] and vim.b[bufnr].last_cursor_position then
    return vim.b[bufnr].last_cursor_position
  else
    return nil
  end
end

M.parse_entry = function(str)
  if str then
    local buf_id, path, row, col, fzf_display_string = str:match("([^:]+)|([^:]+)|([^:]+)|([^:]+)|([^:]+)")

    return {
      buf_id = tonumber(buf_id),
      path = path,
      row = tonumber(row),
      col = tonumber(col),
      fzf_display_string = fzf_display_string
    }
  end
end

M.get_previewer = function()
  local builtin = require("fzf-lua.previewer.builtin")

  local previewer = builtin.buffer_or_file:extend()

  function previewer:new(o, opts, fzf_win)
    previewer.super.new(self, o, opts, fzf_win)
    setmetatable(self, previewer)
    return self
  end

  function previewer:parse_entry(entry_str)
    local t = M.parse_entry(entry_str)
    return {
      idx = t.buf_id,
      path = t.path,
      line = t.row,
      col = t.col,
    }
  end

  return previewer
end

local keymap_header = function(key, purpose)
  return string.format("<%s> %s", fzf_utils.ansi_codes.yellow(key), fzf_utils.ansi_codes.blue(purpose))
end

local function get_header()
  local ctrl_f = keymap_header("ctrl-f", "files")
  local ctrl_x = keymap_header("ctrl-x", "close")
  local ctrl_o = keymap_header("ctrl-i", "reorder up")
  local ctrl_i = keymap_header("ctrl-o", "reorder down")
  local header = string.format("%s | %s | %s | %s", ctrl_f, ctrl_x, ctrl_o, ctrl_i)

  return header
end

M.setup = function()
  -- Cursor position autocommands.
  vim.api.nvim_create_augroup('SaveCursorPos', { clear = true })

  -- Create an autocommand to update the last known cursor position
  vim.api.nvim_create_autocmd({'CursorMoved', 'BufReadPost'}, {
    group = 'SaveCursorPos',
    pattern = '*',
    callback = function()
      -- Get the current buffer number and the cursor position
      local bufnr = vim.api.nvim_get_current_buf()
      local cursor_position = vim.api.nvim_win_get_cursor(0)

      -- Save the cursor position to a buffer variable
      vim.b[bufnr].last_cursor_position = cursor_position
    end,
  })

  -- Buffer entered ts autocommands.
  vim.api.nvim_create_augroup('EnterTs', { clear = true })

  -- Create an autocommand to update the last entered timestamp
  vim.api.nvim_create_autocmd({'BufEnter'}, {
    group = 'EnterTs',
    pattern = '*',
    callback = function()
      -- Get the current buffer number and the cursor position
      local bufnr = vim.api.nvim_get_current_buf()

      -- Save enter ts to a buffer variable
      vim.b[bufnr].last_entered_ts = os.time()
    end,
  })

end

M.get_bufs_table = function()
  local bufs = {}

  -- Get the list of buffer IDs
  local buffer_ids = vim.api.nvim_list_bufs()

  -- Loop through each buffer ID to get additional information.
  for _, buf_id in ipairs(buffer_ids) do
    local path = vim.api.nvim_buf_get_name(buf_id)
    local is_listed = vim.api.nvim_buf_get_option(buf_id, "buflisted")
    local is_loaded = vim.api.nvim_buf_is_loaded(buf_id)

    -- Check if the buffer is loaded and has a file path
    if is_listed and is_loaded and path ~= "" then
      local t = {}

      t.buf_id = buf_id
      t.path = path
      t.relative_path = vim.fn.fnamemodify(path, ':.')

      -- cursor position
      local cursor_pos = M.get_last_cursor_position(t.buf_id)
      t.row = cursor_pos[1]
      t.col = cursor_pos[2]

      table.insert(bufs, t)
    end
  end

  return bufs
end

M.get_bufs = function()

  local bufs = M.get_bufs_table()

  -- Initialize custom order if not set or if buffers have changed
  if M.custom_order == nil then
    M.custom_order = {}
    for _, buf in ipairs(bufs) do
      table.insert(M.custom_order, buf.buf_id)
    end
    -- Sort initial order by buf_id (order buffers were opened)
    table.sort(M.custom_order)
  else
    -- Remove buf_ids that no longer exist and add new ones
    local valid_buf_ids = {}
    for _, buf in ipairs(bufs) do
      valid_buf_ids[buf.buf_id] = true
    end

    -- Filter out closed buffers
    local new_order = {}
    for _, buf_id in ipairs(M.custom_order) do
      if valid_buf_ids[buf_id] then
        table.insert(new_order, buf_id)
        valid_buf_ids[buf_id] = nil
      end
    end

    -- Add new buffers at the end
    for buf_id, _ in pairs(valid_buf_ids) do
      table.insert(new_order, buf_id)
    end

    M.custom_order = new_order
  end

  -- Create a position map for sorting
  local position_map = {}
  for i, buf_id in ipairs(M.custom_order) do
    position_map[buf_id] = i
  end

  -- Sort by custom order
  table.sort(bufs, function(a, b)
    return (position_map[a.buf_id] or math.huge) < (position_map[b.buf_id] or math.huge)
  end)

  local picker_strs = {}

  for _, buf in ipairs(bufs) do
    local fzf_display_string = fzf_utils.ansi_codes.green(buf.relative_path)

    local fzf_full_string = string.format(
      "%s|%s|%s|%s|%s",
      tostring(buf.buf_id),
      buf.path,
      buf.row,
      buf.col,
      fzf_display_string
    )

    table.insert(picker_strs, fzf_full_string)
  end

  return picker_strs
end

M.buffers = function(query)
  -- Call `get_bufs` before calling `fzf_exec`.
  -- This ensures that we preserve the current/alternate buffers before `fzf_exec` creates an unlisted buffer.
  local bufs = M.get_bufs()

  require("fzf-lua").fzf_exec(
    function(cb)
      for _, buf in ipairs(bufs) do
        cb(buf)
      end
      cb()
    end,
    {
      prompt = " > ",
      previewer = M.get_previewer(),
      query = query or "",
      actions = {
        ["default"] = function(selected)
          if selected[1] == nil then
            return
          end

          local buffer = selected[1]
          if buffer then
            local t = M.parse_entry(buffer)
            if t.buf_id then
              -- If the buffer exists, switch to it
              vim.api.nvim_set_current_buf(t.buf_id)
            else
              -- Otherwise, open the file in a new buffer
              vim.cmd('edit ' .. vim.fn.fnameescape(t.path))
            end
          end
        end,
        ["ctrl-x"] = function(selected)
          if selected[1] ~= nil then
            local buffer = selected[1]
            local t = M.parse_entry(buffer)
            if t.buf_id then
              vim.api.nvim_buf_delete(t.buf_id, { force = false })
            end
          end
          M.buffers()
        end,
        ["ctrl-i"] = function(selected, opts)
          -- Move buffer up in the list
          if selected[1] ~= nil then
            local buffer = selected[1]
            local t = M.parse_entry(buffer)

            -- Find the position in custom_order
            for i, buf_id in ipairs(M.custom_order) do
              if buf_id == t.buf_id and i > 1 then
                -- Swap with previous buffer
                M.custom_order[i], M.custom_order[i-1] = M.custom_order[i-1], M.custom_order[i]
                break
              end
            end

            local query = opts.query or ""
            M.buffers(query)
          end
        end,
        ["ctrl-o"] = function(selected, opts)
          -- Move buffer down in the list
          if selected[1] ~= nil then
            local buffer = selected[1]
            local t = M.parse_entry(buffer)

            -- Find the position in custom_order
            for i, buf_id in ipairs(M.custom_order) do
              if buf_id == t.buf_id and i < #M.custom_order then
                -- Swap with next buffer
                M.custom_order[i], M.custom_order[i+1] = M.custom_order[i+1], M.custom_order[i]
                break
              end
            end

            local query = opts.query or ""
            M.buffers(query)
          end
        end,
        ["ctrl-f"] = function(_, opts)
            local query = opts.query or ""
            require('files').files(query)
        end,
      },
      fzf_opts = {
        ["--delimiter"] = "|",
        ["--with-nth"] = "5",
        ["--header"] = get_header(),
      },
    }
  )
end

return M
