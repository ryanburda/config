-- Personal take on `:FzfLua buffers`
--    * Shows leaf of file paths in its own column
--    * Does not reorder based on last used
--    * Allows for list to be reordered
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
local devicons = require("nvim-web-devicons")

local function get_last_cursor_position(bufnr)
  if vim.b[bufnr] and vim.b[bufnr].last_cursor_position then
    return vim.b[bufnr].last_cursor_position
  else
    return nil
  end
end

local function pad_string(input_string, num_characters)
    local length = #input_string

    while length < num_characters do
        input_string = input_string .. " "
        length = length + 1
    end

    return input_string
end

local function get_bufs()
  local bufs = {}
  local max_file_name_length = 0

  -- Loop through each buffer ID to get additional information.
  for idx, buf_id in ipairs(vim.g.buffer_list) do
    local buf = {}

    buf.idx = idx
    buf.buf_id = buf_id
    buf.path = vim.api.nvim_buf_get_name(buf_id)
    buf.relative_path = fzf_utils.ansi_codes.blue(vim.fn.fnamemodify(buf.path, ':.'))
    buf.path_leaf = fzf_utils.ansi_codes.cyan(buf.path:match("([^/\\]+)$"))

    if #buf.path_leaf > max_file_name_length then
      max_file_name_length = #buf.path_leaf
    end

    buf.buf_indicator = " "
    if buf.buf_id == vim.fn.bufnr('%') then
      buf.buf_indicator = fzf_utils.ansi_codes.red('%')
    elseif buf.buf_id == vim.fn.bufnr('#') then
      buf.buf_indicator = fzf_utils.ansi_codes.green('#')
    end

    -- cursor position
    local cursor_pos = get_last_cursor_position(buf.buf_id)
    buf.cursor_row = cursor_pos[1]
    buf.cursor_col = cursor_pos[2]
    buf.cursor_row_colored = tostring(buf.cursor_row)
    buf.cursor_col_colored = tostring(buf.cursor_col)

    -- dirty
    local is_modified = vim.api.nvim_buf_get_option(buf_id, 'modified')
    buf.is_modified_str = " "
    if is_modified then
      buf.is_modified_str = "+"
    end

    -- icon
    local icon, hl = devicons.get_icon_color(buf.path, nil, {default = true})
    buf.icon = fzf_utils.ansi_from_rgb(hl, icon)

    table.insert(bufs, buf)
  end

  local picker_strs = {}

  for _, buf in ipairs(bufs) do
    local fzf_display_string = string.format(
      "%s %s %s %s %s:%s:%s [%s]",
      buf.icon,
      buf.buf_indicator,
      pad_string(buf.path_leaf, max_file_name_length),
      buf.is_modified_str,
      buf.relative_path,
      buf.cursor_row_colored,
      buf.cursor_col_colored,
      tostring(buf.buf_id)
    )

    local fzf_full_string = string.format(
      "%s|%s|%s|%s|%s|%s",
      buf.idx,
      tostring(buf.buf_id),
      buf.path,
      buf.cursor_row,
      buf.cursor_col,
      fzf_display_string
    )

    table.insert(picker_strs, fzf_full_string)
  end

  return picker_strs
end

local function parse_entry(str)
  if str then
    local idx, buf_id, path, row, col, fzf_display_string = str:match("([^:]+)|([^:]+)|([^:]+)|([^:]+)|([^:]+)|([^:]+)")

    return {
      idx = tonumber(idx),
      buf_id = tonumber(buf_id),
      path = path,
      row = tonumber(row),
      col = tonumber(col),
      fzf_display_string = fzf_display_string
    }
  end
end

local function get_previewer()
  local builtin = require("fzf-lua.previewer.builtin")

  local previewer = builtin.buffer_or_file:extend()

  function previewer:new(o, opts, fzf_win)
    previewer.super.new(self, o, opts, fzf_win)
    setmetatable(self, previewer)
    return self
  end

  function previewer:parse_entry(entry_str)
    local t = parse_entry(entry_str)
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
  return string.format("<%s> to %s", fzf_utils.ansi_codes.yellow(key), fzf_utils.ansi_codes.red(purpose))
end

local function get_header()
  local ctrl_x = keymap_header("ctrl-x", "close")
  local ctrl_j = keymap_header("ctrl-j", "reorder down")
  local ctrl_k = keymap_header("ctrl-k", "reorder up")
  local ctrl_g = keymap_header("ctrl-g", "# buffer")
  local header = string.format(":: %s | %s | %s | %s", ctrl_x, ctrl_j, ctrl_k, ctrl_g)

  return header
end


local M = {}

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

  -- Buffer list autocommands
  vim.g.buffer_list = {}
  vim.api.nvim_create_augroup('BufferList', { clear = true })

  vim.api.nvim_create_autocmd({'BufReadPost'}, {
    group = 'BufferList',
    pattern = '*',
    callback = function(event)
      local bufnr = event.buf
      local path = vim.api.nvim_buf_get_name(bufnr)
      local is_listed = vim.api.nvim_buf_get_option(bufnr, "buflisted")
      local is_loaded = vim.api.nvim_buf_is_loaded(bufnr)

      -- Check if the buffer is loaded and has a file path
      local buffer_list = vim.g.buffer_list
      if is_listed and is_loaded and path ~= "" then
        table.insert(buffer_list, bufnr)
      end

      vim.g.buffer_list = buffer_list
    end,
  })

  vim.api.nvim_create_autocmd({'BufDelete'}, {
    group = 'BufferList',
    pattern = '*',
    callback = function(event)
      local buffer_list = vim.g.buffer_list
      for i, v in ipairs(buffer_list) do
        if v == event.buf then
          table.remove(buffer_list, i)
          break
        end
      end

      vim.g.buffer_list = buffer_list
    end,
  })

end

M.buffers = function()
  -- Call `get_bufs` before calling `fzf_exec`.
  -- This ensures that we preserve the current/alternate buffers before `fzf_exec` creates an unlisted buffer.
  local bufs = get_bufs()

  require("fzf-lua").fzf_exec(
    function(cb)
      for _, buf in ipairs(bufs) do
        cb(buf)
      end
      cb()
    end,
    {
      prompt = "bufs> ",
      previewer = get_previewer(),
      actions = {
        ["default"] = function(selected)
          if selected[1] == nil then
            return
          end

          local buffer = selected[1]
          if buffer then
            local t = parse_entry(buffer)
            vim.api.nvim_set_current_buf(t.buf_id)
          end
        end,
        ["ctrl-x"] = function(selected)
          if selected[1] ~= nil then
            local buffer = selected[1]
            local t = parse_entry(buffer)
            vim.api.nvim_buf_delete(t.buf_id, { force = false })
          end
          M.buffers()
        end,
        ["ctrl-j"] = function(selected)
          if selected[1] ~= nil then
            local buffer = selected[1]
            local t = parse_entry(buffer)

            local buffer_list = vim.g.buffer_list

            -- Move the entry down one
            table.remove(buffer_list, t.idx)
            table.insert(buffer_list, math.min(t.idx + 1, #buffer_list + 1), t.buf_id)

            vim.g.buffer_list = buffer_list
          end
          M.buffers()
        end,
        ["ctrl-k"] = function(selected)
          if selected[1] ~= nil then
            local buffer = selected[1]
            local t = parse_entry(buffer)

            local buffer_list = vim.g.buffer_list

            -- Move the entry up one
            table.remove(buffer_list, t.idx)
            table.insert(buffer_list, math.max(t.idx - 1, 1), t.buf_id)

            vim.g.buffer_list = buffer_list
          end
          M.buffers()
        end,
        ["ctrl-g"] = function()
          local alt_bufnr = vim.fn.bufnr('#')

          if alt_bufnr ~= -1 then
            vim.api.nvim_set_current_buf(alt_bufnr)
          end
        end,

      },
      fzf_opts = {
        ["--delimiter"] = "|",
        ["--with-nth"] = "6",
        ["--header"] = get_header(),
      },
    }
  )
end

return M
