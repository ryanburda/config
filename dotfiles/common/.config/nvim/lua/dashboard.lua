--[[
Custom alpha-nvim theme.
  - neovim version
  - current working directory
  - buf-marks
]]
local M = {}

local devicons = require("nvim-web-devicons")

local version = {
  type = "text",
  val = "NVIM v" .. tostring(vim.version()),
  opts = {
    position = "left",
    hl = "Comment",
  },
}

local cwd = {
  type = "text",
  val = function()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
  end,
  opts = {
    position = "left",
    hl = "Directory",
  },
}

--- @param sc string single character shortcut, also used as the keymap lhs
--- @param txt string button label
--- @param keybind string command to run, e.g. "<cmd>ene <CR>"
--- @param hl string|table? highlight for the label text
local function button(sc, txt, keybind, hl)
  local opts = {
    position = "left",
    shortcut = "[" .. sc .. "] ",
    cursor = 1,
    align_shortcut = "left",
    hl_shortcut = { { "Operator", 0, 1 }, { "Number", 1, #sc + 1 }, { "Operator", #sc + 1, #sc + 2 } },
    hl = hl,
    keymap = { "n", sc, keybind, { noremap = true, silent = true, nowait = true } },
  }

  local function on_press()
    local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
    vim.api.nvim_feedkeys(key, "t", false)
  end

  return {
    type = "button",
    val = txt,
    on_press = on_press,
    opts = opts,
  }
end

--- Builds one button per buf-mark (working directory + global), sorted the
--- same way buf-mark sorts them elsewhere (cwd marks first, then global,
--- alphabetically within each group). Pressing the mark's key jumps to it.
local function mark_buttons()
  local buf_mark = require("buf-mark")

  local marks = {}
  for char, path in pairs(buf_mark.list()) do
    table.insert(marks, { char = char, path = path })
  end
  table.sort(marks, function(a, b) return buf_mark.mark_comparator(a.char, b.char) end)

  if #marks == 0 then
    return {
      { type = "text", val = "No buf-marks set", opts = { position = "left", hl = "Comment" } },
    }
  end

  local buttons = {}
  for _, mark in ipairs(marks) do
    local short_path = vim.fn.fnamemodify(mark.path, ":~:.")
    local ico, ico_hl = devicons.get_icon(
      vim.fn.fnamemodify(mark.path, ":t"),
      vim.fn.fnamemodify(mark.path, ":e"),
      { default = true }
    )
    local label = ico and (ico .. "  " .. short_path) or short_path
    local keybind = string.format("<cmd>lua require('buf-mark').goto(%s)<CR>", string.format("%q", mark.char))

    local btn = button(mark.char, label, keybind)
    if ico and ico_hl then
      btn.opts.hl = { { ico_hl, 0, #ico } }
    end
    table.insert(buttons, btn)
  end

  return buttons
end

-- alpha always snaps the cursor onto the first "button" element it renders.
-- Buf-mark buttons are real buttons so their keymaps work, so an invisible
-- one here as the very first layout element keeps the cursor at the top-left
-- on open instead of jumping onto the first buf-mark.
local top_left_anchor = {
  type = "button",
  val = "",
  on_press = function() end,
  opts = { position = "left", cursor = 0 },
}

local config = {
  layout = {
    top_left_anchor,
    { type = "padding", val = 1 },
    version,
    { type = "padding", val = 1 },
    cwd,
    { type = "padding", val = 1 },
    {
      type = "group",
      val = function() return mark_buttons() end,
    },
  },
  opts = {
    margin = 5,
    setup = function()
      -- Keep the dashboard's buf-mark buttons in sync while it's open.
      vim.api.nvim_create_autocmd("User", {
        pattern = "BufMarkChanged",
        group = vim.api.nvim_create_augroup("dashboard_buf_mark_refresh", { clear = true }),
        callback = function()
          if vim.bo.filetype == "alpha" then
            require("alpha").redraw()
          end
        end,
      })

      -- Refresh the cwd line and buf-mark paths when the working directory changes.
      vim.api.nvim_create_autocmd("DirChanged", {
        group = vim.api.nvim_create_augroup("dashboard_dir_changed_refresh", { clear = true }),
        callback = function()
          if vim.bo.filetype == "alpha" then
            require("alpha").redraw()
          end
        end,
      })

      -- 'j'/'k' would otherwise just move the cursor line by line; disable
      -- them here so every single-character key is free to be a buf-mark
      -- shortcut instead.
      vim.keymap.set("n", "j", "<Nop>", { buffer = 0, silent = true })
      vim.keymap.set("n", "k", "<Nop>", { buffer = 0, silent = true })
    end,
  },
}

M.config = config

return M
