-- Show buffers in a way that is easier on the eyes.
--
-- TODO:
--    * Add <C-g> jump to alternate buffer
--    * Add <C-j> and <C-k> to reorder buffer list
--    * Fix current and alternate buffer indicators
--    * Fix row/column (they're all the same value)
local fzf_utils = require("fzf-lua.utils")
local devicons = require("nvim-web-devicons")

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

  -- Get the list of buffer IDs
  local buffer_ids = vim.api.nvim_list_bufs()

  local max_file_name_length = 0

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

      -- path
      t.relative_path = fzf_utils.ansi_codes.blue(vim.fn.fnamemodify(path, ':.'))
      t.path_leaf = fzf_utils.ansi_codes.green(path:match("([^/\\]+)$"))

      if #t.path_leaf > max_file_name_length then
        max_file_name_length = #t.path_leaf
      end

      t.buf_indicator = " "
      if t.buf_id == vim.fn.bufnr('%') then
        t.buf_indicator = fzf_utils.ansi_codes.grey('%')
      elseif t.buf_id == vim.fn.bufnr('#') then
        t.buf_indicator = fzf_utils.ansi_codes.grey('#')
      end

      -- cursor position
      local cursor_pos = vim.api.nvim_buf_get_mark(t.buf_id, '"')
      t.cursor_row = cursor_pos[1]
      t.cursor_col = cursor_pos[2]
      t.cursor_row_colored = fzf_utils.ansi_codes.yellow(tostring(t.cursor_row))
      t.cursor_col_colored = fzf_utils.ansi_codes.cyan(tostring(t.cursor_col))

      -- dirty
      local is_modified = vim.api.nvim_buf_get_option(buf_id, 'modified')
      t.is_modified_str = " "
      if is_modified then
        t.is_modified_str = "+"
      end

      -- icon
      local icon, hl = devicons.get_icon_color(path, nil, {default = true})
      t.icon = fzf_utils.ansi_from_rgb(hl, icon)

      table.insert(bufs, t)
    end
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
      "%s|%s|%s|%s|%s",
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

local keymap_header = function(key, purpose)
  return string.format("<%s> to %s", fzf_utils.ansi_codes.yellow(key), fzf_utils.ansi_codes.red(purpose))
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

local function get_header()
  local ctrl_x = keymap_header("ctrl-x", "close")
  local header = string.format(":: %s", ctrl_x)

  return header
end


local M = {}

M.buffers = function()
  require("fzf-lua").fzf_exec(
    function(cb)
      local bufs = get_bufs()
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
          require("fzf-lua").resume()
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
