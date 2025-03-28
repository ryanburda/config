-- Personal take on a combination between `:FzfLua buffers` and `FzfLua files`.
--    * Buffers are shown at the top
--      * Shows leaf of file paths in its own column
--      * Orders buffers alphabetically based on leaf of path
--    * Files are shown below buffers
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
        t.buf_indicator = fzf_utils.ansi_codes.red('%')
      elseif t.buf_id == vim.fn.bufnr('#') then
        t.buf_indicator = fzf_utils.ansi_codes.yellow('#')
      end

      -- cursor position
      local cursor_pos = get_last_cursor_position(t.buf_id)
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

  -- Sort alphabetically by file name.
  table.sort(bufs, function(a, b) return a.path_leaf < b.path_leaf end)
  -- Sort by bufnr (order buffers were opened)
  -- table.sort(bufs, function(a, b) return a.buf_id < b.buf_id end)
  -- Sort by last used
  -- table.sort(bufs, function(a, b) return vim.b[a.buf_id].last_entered_ts > vim.b[b.buf_id].last_entered_ts end)

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

local function get_files()
  local command = os.getenv("FZF_DEFAULT_COMMAND")
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()

  local buf_paths = {}
  local buffers = get_bufs()
  for _, buf in ipairs(buffers) do
    local relpath = vim.fn.fnamemodify(parse_entry(buf).path, ':.')
    table.insert(buf_paths, relpath)
  end

  -- Get all files, removing buffers from the list.
  local files = {}

  for filename in string.gmatch(result, "[^\n]+") do
    local is_buf = false

    for _, buf_path in ipairs(buf_paths) do
      if buf_path == filename then
        is_buf = true
        break
      end
    end

    if not is_buf then
      table.insert(files, filename)
    end
  end

  local picker_strs = {}

  for _, path in ipairs(files) do
    -- icon
    local icon, hl = devicons.get_icon_color(path, nil, {default = true})
    local icon_colored = fzf_utils.ansi_from_rgb(hl, icon)

    local fzf_display_string = string.format(
      "%s   %s%s",
      icon_colored,
      -- HACK: fzf sorts based off length. This will make files sink to the bottoms to allow buffers to stay on top.
      fzf_utils.ansi_codes.blue(path),
      "                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   :"
    )

    local fzf_full_string = string.format(
      "%s|%s|%s|%s|%s",
      nil,
      path,
      nil,
      nil,
      fzf_display_string
    )

    table.insert(picker_strs, fzf_full_string)
  end

  return picker_strs

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
  local ctrl_g = keymap_header("ctrl-g", "alternate buffer #")
  local ctrl_x = keymap_header("ctrl-x", "close buffer")
  local ctrl_o = keymap_header("ctrl-o", "close all but selected buffer")
  local header = string.format("  %s | %s | %s", ctrl_g, ctrl_x, ctrl_o)

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

M.buffers = function()
  -- Call `get_bufs` before calling `fzf_exec`.
  -- This ensures that we preserve the current/alternate buffers before `fzf_exec` creates an unlisted buffer.
  local bufs = get_bufs()
  local files = get_files()

  for i = 1, #files do
      table.insert(bufs, files[i])
  end

  require("fzf-lua").fzf_exec(
    function(cb)
      for _, buf in ipairs(bufs) do
        cb(buf)
      end
      cb()
    end,
    {
      prompt = "open> ",
      previewer = get_previewer(),
      actions = {
        ["default"] = function(selected)
          if selected[1] == nil then
            return
          end

          local buffer = selected[1]  -- TOOD: rename this since this contains both buffers and files.
          if buffer then
            local t = parse_entry(buffer)
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
            local t = parse_entry(buffer)
            if t.buf_id then
              vim.api.nvim_buf_delete(t.buf_id, { force = false })
            end
          end
          M.buffers()
        end,
        ["ctrl-g"] = function()
          local alt_bufnr = vim.fn.bufnr('#')

          if alt_bufnr ~= -1 then
            vim.api.nvim_set_current_buf(alt_bufnr)
          end
        end,
        ["ctrl-o"] = function(selected)
          if selected[1] ~= nil then
            local buffer = selected[1]
            local t = parse_entry(buffer)

            -- get list of buffers
            local buffers = get_bufs()

            for _, buf in ipairs(buffers) do
              local parsed_buf = parse_entry(buf)
              if t.buf_id ~= parsed_buf.buf_id then
                vim.api.nvim_buf_delete(parsed_buf.buf_id, { force = false })
              end
            end
          end

          M.buffers()
        end
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
