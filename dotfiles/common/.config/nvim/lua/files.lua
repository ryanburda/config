-- Personal take on `FzfLua files` that shows buffers in a different color.
local fzf_utils = require("fzf-lua.utils")

local M = {}

-- Sort mode: "default" or "access_time"
M.sort_mode = "default"

local function get_files()
  local command = os.getenv("FZF_DEFAULT_COMMAND")
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()

  local files = {}

  for filename in string.gmatch(result, "[^\n]+") do
      table.insert(files, filename)
  end

  -- Sort by last access time if needed
  if M.sort_mode == "access_time" then
    table.sort(files, function(a, b)
      local stat_a = vim.loop.fs_stat(a)
      local stat_b = vim.loop.fs_stat(b)

      if stat_a and stat_b then
        -- Sort by access time (most recent first)
        return stat_a.atime.sec > stat_b.atime.sec
      elseif stat_a then
        return true
      elseif stat_b then
        return false
      else
        return a < b
      end
    end)
  end

  local buffers = require('bufs').get_bufs_table()

  local picker_strs = {}
  for _, path in ipairs(files) do
    -- add buffer information if the file is currently open.
    local buf_id, col, row = nil, nil, nil
    local display_path = path

    for _, buffer in ipairs(buffers) do
      if vim.fn.fnamemodify(buffer.path, ':.') == path then
        display_path = fzf_utils.ansi_codes.green(path)
        buf_id = buffer.buf_id
        row = buffer.row
        col = buffer.col
        break
      end
    end

    local fzf_display_string = display_path
    local fzf_full_string = string.format("%s|%s|%s|%s|%s", path, buf_id, row, col, fzf_display_string)

    table.insert(picker_strs, fzf_full_string)
  end

  return picker_strs

end

local function parse_entry(str)
  if str then
    local path, buf_id, row, col, fzf_display_string = str:match("([^:]+)|([^:]+)|([^:]+)|([^:]+)|([^:]+)")

    return {
      path = path,
      buf_id = tonumber(buf_id),
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
  return string.format("<%s> %s", fzf_utils.ansi_codes.yellow(key), fzf_utils.ansi_codes.blue(purpose))
end

local function get_header()
  local ctrl_f = keymap_header("ctrl-f", "buffers")
  local ctrl_s = keymap_header("ctrl-s", "sort")
  local header = string.format("%s | %s", ctrl_f, ctrl_s)

  return header
end

M.files = function(query, sort_mode)
  -- Default to "default" mode if not specified
  M.sort_mode = sort_mode or "default"

  local files = get_files()

  require("fzf-lua").fzf_exec(
    function(cb)
      for _, file in ipairs(files) do
        cb(file)
      end
      cb()
    end,
    {
      prompt = " > ",
      previewer = get_previewer(),
      query = query or "",
      actions = {
        ["default"] = function(selected)
          if selected[1] == nil then
            return
          end

          local path = selected[1]
          if path then
            local t = parse_entry(path)
            if t.buf_id then
              -- If the buffer exists, switch to it
              vim.api.nvim_set_current_buf(t.buf_id)
            else
              -- Otherwise, open the file in a new buffer
              vim.cmd('edit ' .. vim.fn.fnameescape(t.path))
            end
          end
        end,
        ["ctrl-f"] = function(_, opts)
            local query = opts.query or ""
            require('bufs').buffers(query)
        end,
        ["ctrl-s"] = function(_, opts)
            -- Toggle sort mode
            local new_mode = M.sort_mode == "default" and "access_time" or "default"

            local query = opts.query or ""
            M.files(query, new_mode)
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
