--[[
Custom alpha-nvim theme: Neovim's own intro screen (`:intro`), with the
current working directory and the buf-marks appended underneath it.

The intro is reproduced by hand rather than read from Neovim -- the real one is
drawn straight to the screen from C and is never exposed to Lua.
]]
local M = {}

local devicons = require("nvim-web-devicons")

-- Neovim draws its intro as a 44 cell wide block: the horizontal rules and the
-- "Nvim is open source and freely distributable" line are both exactly that wide.
local INTRO_WIDTH = 44
-- Column the right hand side of the "type  :cmd<Enter>   description" rows starts at.
local DESC_COL = 28

local function disp(s)
  return vim.fn.strdisplaywidth(s)
end

--- Right-pads `line` out to `width`. alpha centres every element by its own
--- longest line, so padding each line to a common width is what keeps separate
--- elements sharing a single left edge.
local function pad_right(line, width)
  return line .. string.rep(" ", math.max(0, width - disp(line)))
end

--- Centres `line` inside `width`, shifting the byte ranges in `hls` by the
--- padding that was inserted so the highlights still land on the right
--- characters. Returns the padded line and the shifted highlights.
local function centered(line, width, hls)
  local left = math.floor((width - disp(line)) / 2)
  local shifted
  if hls then
    shifted = {}
    for i, h in ipairs(hls) do
      shifted[i] = { h[1], h[2] + left, h[3] + left }
    end
  end
  return pad_right(string.rep(" ", left) .. line, width), shifted
end

--- @param line string already padded to its block width
--- @param hl string|table? highlight group, or alpha's { group, from, to } ranges
local function text(line, hl)
  return { type = "text", val = { line }, opts = { position = "center", hl = hl } }
end

local function rule()
  return text(string.rep("─", INTRO_WIDTH), "NonText")
end

-- Neovim's "N", two-toned the way the real intro draws it: the upright strokes
-- on the left in Special, the diagonal and the strokes on the right in String.
-- The ranges are byte offsets; every box drawing character here is 3 bytes.
local LOGO = {
  { "│ ╲ ││", { { "Special", 0, 3 }, { "String", 4, 7 }, { "String", 8, 14 } } },
  { "││╲╲││", { { "Special", 0, 6 }, { "String", 6, 18 } } },
  { "││ ╲ │", { { "Special", 0, 6 }, { "String", 7, 10 }, { "String", 11, 14 } } },
}

--- Builds one "type  :cmd<Enter>   description" row along with the highlights
--- Neovim gives it: the ':' and the '<Enter>' in Special, the command in
--- Identifier, everything else left as normal text.
local function type_line(cmd, desc)
  local prefix = "type  "
  local enter = "<Enter>"
  local lhs = prefix .. ":" .. cmd .. enter
  local line = lhs .. string.rep(" ", math.max(1, DESC_COL - disp(lhs))) .. desc
  local colon = #prefix
  local cmd_end = colon + 1 + #cmd
  return pad_right(line, INTRO_WIDTH), {
    { "Special", colon, colon + 1 },
    { "Identifier", colon + 1, cmd_end },
    { "Special", cmd_end, cmd_end + #enter },
  }
end

--- The version as the intro prints it, e.g. "NVIM v0.12.5". `build` already
--- carries the "v" prefix plus any dev suffix, so prefer it when it's there.
local function version_string()
  local v = vim.version()
  if type(v.build) == "string" and v.build:match("^v") then
    return "NVIM " .. v.build
  end
  return string.format("NVIM v%d.%d.%d", v.major, v.minor, v.patch)
end

--- The intro block, line for line from `:intro`.
local function intro_elements()
  local v = vim.version()
  local els = {}

  for _, logo_line in ipairs(LOGO) do
    els[#els + 1] = text(centered(logo_line[1], INTRO_WIDTH, logo_line[2]))
  end

  els[#els + 1] = text("")
  els[#els + 1] = text(centered(version_string(), INTRO_WIDTH), "String")
  els[#els + 1] = rule()
  els[#els + 1] = text("Nvim is open source and freely distributable")
  els[#els + 1] = text(centered("https://neovim.io/#chat", INTRO_WIDTH))
  els[#els + 1] = rule()
  els[#els + 1] = text(type_line("help nvim", "if you are new!"))
  els[#els + 1] = text(type_line("checkhealth", "to optimize Nvim"))
  els[#els + 1] = text(type_line("q", "to exit"))
  els[#els + 1] = text(type_line("help", "for help"))
  els[#els + 1] = rule()
  els[#els + 1] = text(type_line("help news", string.format("for v%d.%d notes", v.major, v.minor)))
  els[#els + 1] = rule()
  els[#els + 1] = text(centered("Help poor children in Uganda!", INTRO_WIDTH))
  els[#els + 1] = text(type_line("help Kuwasha", "for information"))

  return els
end

--- @param sc string single character shortcut, also used as the keymap lhs
--- @param txt string button label
--- @param keybind string command to run, e.g. "<cmd>ene <CR>"
--- @param width number total width to pad the rendered button out to
--- @param hl string|table? highlight for the label text
local function button(sc, txt, keybind, width, hl)
  local opts = {
    position = "center",
    shortcut = "[" .. sc .. "] ",
    cursor = 1,
    align_shortcut = "left",
    width = width,
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
    return { text(centered("No buf-marks set", INTRO_WIDTH), "Comment") }
  end

  -- Build every label up front so the widest one can set a single width for
  -- all of the buttons. alpha centres each button on its own, so without that
  -- they'd each sit at a different left edge instead of forming a list.
  local rows = {}
  local width = INTRO_WIDTH
  for i, mark in ipairs(marks) do
    local short_path = vim.fn.fnamemodify(mark.path, ":~:.")
    local ico, ico_hl = devicons.get_icon(
      vim.fn.fnamemodify(mark.path, ":t"),
      vim.fn.fnamemodify(mark.path, ":e"),
      { default = true }
    )
    local shortcut = "[" .. mark.char .. "] "
    rows[i] = {
      char = mark.char,
      path = mark.path,
      label = ico and (ico .. "  " .. short_path) or short_path,
      ico = ico,
      ico_hl = ico_hl,
    }
    width = math.max(width, disp(shortcut) + disp(rows[i].label))
  end

  local buttons = {}
  for i, row in ipairs(rows) do
    local keybind = string.format("<cmd>lua require('buf-mark').goto(%s)<CR>", string.format("%q", row.char))
    local btn = button(row.char, row.label, keybind, width)
    if row.ico and row.ico_hl then
      btn.opts.hl = { { row.ico_hl, 0, #row.ico } }
    end
    buttons[i] = btn
  end

  return buttons
end

--- The working directory, in its own section between two rules so it reads as
--- part of the intro. Deep paths are trimmed from the left rather than allowed
--- to widen the block past the rules.
local function cwd_elements()
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
  local ellipsis = "…/"
  while disp(cwd) > INTRO_WIDTH do
    local rest = cwd
    if rest:sub(1, #ellipsis) == ellipsis then
      rest = rest:sub(#ellipsis + 1)
    end
    -- Drop the leading path component. Matching the ellipsis inside the
    -- pattern itself isn't an option: Lua patterns are byte-wise, so '?' would
    -- only make its last byte optional.
    local shorter = rest:match("^/?[^/]+/(.+)$")
    if not shorter then
      break
    end
    cwd = ellipsis .. shorter
  end
  return {
    rule(),
    text(centered(cwd, INTRO_WIDTH), "Directory"),
    rule(),
  }
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

--- Everything, in one group so that `v_center` can sit the whole screen in the
--- middle of the window the way Neovim's intro does.
local function layout_elements()
  local els = { top_left_anchor }
  local function append(list)
    for _, el in ipairs(list) do
      els[#els + 1] = el
    end
  end

  append(intro_elements())
  append(cwd_elements())
  append(mark_buttons())

  return els
end

local config = {
  layout = {
    {
      type = "group",
      val = layout_elements,
      opts = { position = "v_center" },
    },
  },
  opts = {
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
