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

local function get_files()
  local command = os.getenv("FZF_DEFAULT_COMMAND")
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()

  local files = {}

  for filename in string.gmatch(result, "[^\n]+") do
      table.insert(files, filename)
  end

  local picker_strs = {}

  for _, path in ipairs(files) do
    -- icon
    local icon, hl = devicons.get_icon_color(path, nil, {default = true})
    local icon_colored = fzf_utils.ansi_from_rgb(hl, icon)

    local fzf_display_string = string.format(
      "%s   %s",
      icon_colored,
      path
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

local M = {}

M.files = function(query)
  -- Call `get_bufs` before calling `fzf_exec`.
  -- This ensures that we preserve the current/alternate buffers before `fzf_exec` creates an unlisted buffer.
  local bufs = require('bufs').get_bufs()
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
      prompt = "files>",
      previewer = get_previewer(),
      query = query or "",
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
        end,
        ["ctrl-l"] = function(_, opts)
            local query = opts.query or ""
            require('bufs').buffers(query)
        end,
      },
      fzf_opts = {
        ["--delimiter"] = "|",
        ["--with-nth"] = "5",
      },
    }
  )
end

return M
