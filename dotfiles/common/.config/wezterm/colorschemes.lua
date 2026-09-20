--[[

WezTerm color schemes derived from the Neovim colorschemes in
`set_colorscheme`. One entry per Neovim colorscheme, keyed by
"<nvim_colorscheme>-<nvim_background>" so WezTerm never needs its own
theme name -- picking a Neovim colorscheme picks the terminal palette.

Colors come from each colorscheme itself: `terminal_color_0..15` plus the
Normal/Cursor/Visual/TabLine highlight groups, read out of a headless
Neovim. The exceptions are noted inline.

`ansi`/`brights` are NOT in ANSI order which normally looks like this:
  0 = black
  1 = red
  2 = green
  3 = yellow
  4 = blue
  5 = magenta
  6 = cyan
  7 = white
Slots 1-7 are instead sorted by how much of a screenful of code each color
actually paints: slot 1 is always the scheme's dominant color, slot 2 the
next, down to slot 7 for the least-used. That way setting something like
tmux's `pane-active-border-style "fg=1"` results in using the most dominant
color in the palette instead of being that colorscheme's version of red.
Slot 0 always stays black.

The ranking comes from the Neovim colorscheme itself: every common token
role (@string, @function, @keyword, @property, @type, @comment, ...) is
weighted by roughly how often it shows up in real code and attributed to
the nearest palette entry, so e.g. everforest's green functions outrank its
red keywords. Roles painted in a color the terminal palette doesn't carry
(nordic's orange keywords) and plain `@variable` (the default foreground)
don't vote.

I do sometimes change the color order to taste, usually ranking the palettes
natural red color lower down the list.

--]]

return {
  -- Dark - Catppuccin
  ["catppuccin-dark"] = {
    foreground = "#cdd6f4",
    background = "#1e1e2e",
    cursor_bg = "#f5e0dc",
    cursor_fg = "#1e1e2e",
    cursor_border = "#f5e0dc",
    selection_bg = "#585b70",
    selection_fg = "#cdd6f4",
    split = "#6c7086",
    ansi = { "#181825", "#89b4fa", "#bac2de", "#f5c2e7", "#a6e3a1", "#f9e2af", "#94e2d5", "#f38ba8" },
    brights = { "#313244", "#89b4fa", "#a6adc8", "#f5c2e7", "#a6e3a1", "#f9e2af", "#94e2d5", "#f38ba8" },
    tab_bar = {
      background = "#11111b",
      active_tab = { bg_color = "#45475a", fg_color = "#cdd6f4" },
      inactive_tab = { bg_color = "#181825", fg_color = "#a6adc8" },
      inactive_tab_hover = { bg_color = "#313244", fg_color = "#cdd6f4" },
      new_tab = { bg_color = "#181825", fg_color = "#a6adc8" },
      new_tab_hover = { bg_color = "#313244", fg_color = "#cdd6f4" },
    },
  },

  -- Dark - Everforest
  ["everforest-dark"] = {
    foreground = "#d3c6aa",
    background = "#2d353b",
    cursor_bg = "#d3c6aa",
    cursor_fg = "#2d353b",
    cursor_border = "#d3c6aa",
    selection_bg = "#543a48",
    selection_fg = "#d3c6aa",
    split = "#4f585e",
    ansi = { "#343f44", "#a7c080", "#7fbbb3", "#e67e80", "#83c092", "#dbbc7f", "#d699b6", "#d3c6aa" },
    brights = { "#3d484d", "#b7cb97", "#96c7c1", "#ea9597", "#99cba6", "#e1c896", "#ddabc3", "#dacfb7" },
    tab_bar = {
      background = "#343f44",
      active_tab = { bg_color = "#a7c080", fg_color = "#2d353b" },
      inactive_tab = { bg_color = "#475258", fg_color = "#9da9a0" },
      inactive_tab_hover = { bg_color = "#343f44", fg_color = "#d3c6aa" },
      new_tab = { bg_color = "#475258", fg_color = "#9da9a0" },
      new_tab_hover = { bg_color = "#343f44", fg_color = "#d3c6aa" },
    },
  },

  -- Dark - Gruvbox
  ["gruvbox-material-dark"] = {
    foreground = "#d4be98",
    background = "#282828",
    cursor_bg = "#d4be98",
    cursor_fg = "#282828",
    cursor_border = "#d4be98",
    selection_bg = "#45403d",
    selection_fg = "#d4be98",
    split = "#5a524c",
    ansi = { "#32302f", "#b8c381", "#7daea3", "#ea6962", "#89b482", "#dfb675", "#d3869b", "#d4be98" },
    brights = { "#504945", "#a9b665", "#94bdb4", "#ee847e", "#9ec298", "#d8a657", "#db9cad", "#dac8a7" },
    tab_bar = {
      background = "#32302f",
      active_tab = { bg_color = "#a89984", fg_color = "#282828" },
      inactive_tab = { bg_color = "#504945", fg_color = "#ddc7a1" },
      inactive_tab_hover = { bg_color = "#32302f", fg_color = "#d4be98" },
      new_tab = { bg_color = "#504945", fg_color = "#ddc7a1" },
      new_tab_hover = { bg_color = "#32302f", fg_color = "#d4be98" },
    },
  },

  -- Dark - Kanagawa-paper-ink
  ["kanagawa-paper-ink-dark"] = {
    foreground = "#dcd7ba",
    background = "#1f1f28",
    cursor_bg = "#dcd7ba",
    cursor_fg = "#1f1f28",
    cursor_border = "#dcd7ba",
    selection_bg = "#363646",
    selection_fg = "#dcd7ba",
    split = "#8992a7",
    ansi = { "#2a2a37", "#a292a3", "#8ea49e", "#c4746e", "#c4b28a", "#435965", "#699469", "#c8c093" },
    brights = { "#363646", "#b4a7b5", "#96ada7", "#cc928e", "#d4c196", "#698a9b", "#72a072", "#d5cd9d" },
    tab_bar = {
      background = "#16161d",
      active_tab = { bg_color = "#1f1f28", fg_color = "#c5c9c5" },
      -- Exception: TabLine's own fg (#393836) is invisible on #16161d, so the
      -- inactive label uses Comment instead.
      inactive_tab = { bg_color = "#16161d", fg_color = "#727169" },
      inactive_tab_hover = { bg_color = "#2a2a37", fg_color = "#dcd7ba" },
      new_tab = { bg_color = "#16161d", fg_color = "#727169" },
      new_tab_hover = { bg_color = "#2a2a37", fg_color = "#dcd7ba" },
    },
  },

  -- Dark - Nightfox-dusk
  ["duskfox-dark"] = {
    foreground = "#e0def4",
    background = "#232136",
    cursor_bg = "#e0def4",
    cursor_fg = "#232136",
    cursor_border = "#e0def4",
    selection_bg = "#433c59",
    selection_fg = "#e0def4",
    split = "#191726",
    ansi = { "#191726", "#569fba", "#a3be8c", "#c4a7e7", "#9ccfd8", "#e0def4", "#f6c177", "#eb6f92" },
    brights = { "#373354", "#65b1cd", "#b1d196", "#ccb1ed", "#a6dae3", "#e2e0f7", "#f9cb8c", "#f083a2" },
    tab_bar = {
      background = "#191726",
      active_tab = { bg_color = "#6e6a86", fg_color = "#232136" },
      inactive_tab = { bg_color = "#2d2a45", fg_color = "#cdcbe0" },
      inactive_tab_hover = { bg_color = "#373354", fg_color = "#e0def4" },
      new_tab = { bg_color = "#2d2a45", fg_color = "#cdcbe0" },
      new_tab_hover = { bg_color = "#373354", fg_color = "#e0def4" },
    },
  },

  -- Dark - Nightfox-night
  ["nightfox-dark"] = {
    foreground = "#cdcecf",
    background = "#192330",
    cursor_bg = "#cdcecf",
    cursor_fg = "#192330",
    cursor_border = "#cdcecf",
    selection_bg = "#2b3b51",
    selection_fg = "#cdcecf",
    split = "#131a24",
    ansi = { "#131a24", "#719cd6", "#81b29a", "#9d79d6", "#63cdcf", "#dfdfe0", "#dbc074", "#c94f6d" },
    brights = { "#29394f", "#86abdc", "#8ebaa4", "#baa1e2", "#7ad5d6", "#e4e4e5", "#e0c989", "#d16983" },
    tab_bar = {
      background = "#131a24",
      active_tab = { bg_color = "#71839b", fg_color = "#192330" },
      inactive_tab = { bg_color = "#212e3f", fg_color = "#aeafb0" },
      inactive_tab_hover = { bg_color = "#29394f", fg_color = "#cdcecf" },
      new_tab = { bg_color = "#212e3f", fg_color = "#aeafb0" },
      new_tab_hover = { bg_color = "#29394f", fg_color = "#cdcecf" },
    },
  },

  -- Dark - Nightfox-nord
  ["nordfox-dark"] = {
    foreground = "#cdcecf",
    background = "#2e3440",
    cursor_bg = "#cdcecf",
    cursor_fg = "#2e3440",
    cursor_border = "#cdcecf",
    selection_bg = "#3e4a5b",
    selection_fg = "#cdcecf",
    split = "#232831",
    ansi = { "#232831", "#81a1c1", "#a3be8c", "#b48ead", "#88c0d0", "#e5e9f0", "#ebcb8b", "#bf616a" },
    brights = { "#3f4c5c", "#8cafd2", "#b1d196", "#c895bf", "#93ccdc", "#e7ecf4", "#f0d399", "#d06f79" },
    tab_bar = {
      background = "#232831",
      active_tab = { bg_color = "#7e8188", fg_color = "#2e3440" },
      inactive_tab = { bg_color = "#39404f", fg_color = "#abb1bb" },
      inactive_tab_hover = { bg_color = "#444c5e", fg_color = "#cdcecf" },
      new_tab = { bg_color = "#39404f", fg_color = "#abb1bb" },
      new_tab_hover = { bg_color = "#444c5e", fg_color = "#cdcecf" },
    },
  },

  -- Dark - Nordic
  ["nordic-dark"] = {
    foreground = "#c0c8d8",
    background = "#242933",
    cursor_bg = "#c0c8d8",
    cursor_fg = "#191d24",
    cursor_border = "#c0c8d8",
    -- Exception: nordic's Visual is #1b1f26, darker than Normal's bg and legible
    -- only because it also sets bold, which a terminal selection can't do. gray2
    -- is nordic's next surface up and reads as a selection on its own.
    selection_bg = "#3b4252",
    selection_fg = "#c0c8d8",
    split = "#191d24",
    ansi = { "#1a1d23", "#5e81ac", "#8fbcbb", "#b48ead", "#a3be8c", "#c0c8d8", "#ebcb8b", "#bf616a" },
    brights = { "#2e3440", "#88c0d0", "#9fc6c5", "#be9db8", "#b1c89d", "#d8dee9", "#efd49f", "#c5727a" },
    tab_bar = {
      background = "#191d24",
      active_tab = { bg_color = "#242933", fg_color = "#d8dee9" },
      inactive_tab = { bg_color = "#191d24", fg_color = "#c0c8d8" },
      inactive_tab_hover = { bg_color = "#2e3440", fg_color = "#c0c8d8" },
      new_tab = { bg_color = "#191d24", fg_color = "#c0c8d8" },
      new_tab_hover = { bg_color = "#2e3440", fg_color = "#c0c8d8" },
    },
  },

  -- Dark - Vague
  ["vague-dark"] = {
    foreground = "#cdcdcd",
    background = "#141415",
    cursor_bg = "#cdcdcd",
    cursor_fg = "#141415",
    cursor_border = "#cdcdcd",
    selection_bg = "#333738",
    selection_fg = "#cdcdcd",
    split = "#878787",
    ansi = { "#1e1e27", "#6e94b2", "#f3be7c", "#cdcdcd", "#aeaed1", "#d8647e", "#bb9dbd", "#7fa563" },
    brights = { "#2a273f", "#8ba9c1", "#f5cb96", "#d7d7d7", "#bebeda", "#e08398", "#c9b1ca", "#99b782" },
    tab_bar = {
      background = "#1c1c24",
      active_tab = { bg_color = "#333738", fg_color = "#cdcdcd" },
      inactive_tab = { bg_color = "#1c1c24", fg_color = "#606079" },
      inactive_tab_hover = { bg_color = "#252530", fg_color = "#cdcdcd" },
      new_tab = { bg_color = "#1c1c24", fg_color = "#606079" },
      new_tab_hover = { bg_color = "#252530", fg_color = "#cdcdcd" },
    },
  },

  -- Dark - Zenbones
  ["zenbones-dark"] = {
    foreground = "#b4bdc3",
    background = "#1c1917",
    cursor_bg = "#c4cacf",
    cursor_fg = "#1c1917",
    cursor_border = "#c4cacf",
    selection_bg = "#3d4042",
    selection_fg = "#b4bdc3",
    split = "#685f5a",
    -- Exception: slots 2-7 are desaturated well below what the colorscheme ships.
    -- zenbones paints code almost entirely in fg and gray, so its accents only
    -- ever show up in terminal output, where full-strength Nord-ish hues look
    -- pasted on. Hue and relative order are kept; saturation is dropped to a
    -- tint and lightness flattened to one step per row.
    ansi = { "#302b29", "#b4bdc3", "#869677", "#988279", "#798b98", "#997a93", "#789497", "#9b7d81" },
    brights = { "#403833", "#888f94", "#a2b094", "#b2a097", "#97a8b2", "#b499af", "#95aeb1", "#b59b9e" },
    tab_bar = {
      background = "#272321",
      -- TabLineSel clears fg/bg, i.e. falls through to Normal.
      active_tab = { bg_color = "#1c1917", fg_color = "#b4bdc3" },
      -- Exception: the light entry dims the inactive label with TabLineFill's fg,
      -- but on dark that group is brighter than Normal's fg and would make the
      -- inactive tabs louder than the active one. terminal_color_15 is zenbones'
      -- dimmed foreground in both backgrounds, so use it here.
      inactive_tab = { bg_color = "#352f2d", fg_color = "#888f94" },
      inactive_tab_hover = { bg_color = "#25211f", fg_color = "#b4bdc3" },
      new_tab = { bg_color = "#352f2d", fg_color = "#888f94" },
      new_tab_hover = { bg_color = "#25211f", fg_color = "#b4bdc3" },
    },
  },

  -- Light - Everforest
  ["everforest-light"] = {
    foreground = "#5c6a72",
    background = "#fdf6e3",
    cursor_bg = "#5c6a72",
    cursor_fg = "#fdf6e3",
    cursor_border = "#5c6a72",
    selection_bg = "#eaedc8",
    selection_fg = "#5c6a72",
    split = "#e0dcc7",
    ansi = { "#f4f0d9", "#8da101", "#3a94c5", "#f85552", "#35a77c", "#dfa000", "#df69ba", "#e6e2cc" },
    brights = { "#e6e2cc", "#8da101", "#3a94c5", "#f85552", "#35a77c", "#dfa000", "#df69ba", "#ebe8d6" },
    tab_bar = {
      background = "#f4f0d9",
      active_tab = { bg_color = "#93b259", fg_color = "#fdf6e3" },
      inactive_tab = { bg_color = "#e6e2cc", fg_color = "#829181" },
      inactive_tab_hover = { bg_color = "#f4f0d9", fg_color = "#5c6a72" },
      new_tab = { bg_color = "#e6e2cc", fg_color = "#829181" },
      new_tab_hover = { bg_color = "#f4f0d9", fg_color = "#5c6a72" },
    },
  },

  -- Light - Gruvbox
  ["gruvbox-material-light"] = {
    foreground = "#654735",
    background = "#fbf1c7",
    cursor_bg = "#654735",
    cursor_fg = "#fbf1c7",
    cursor_border = "#654735",
    selection_bg = "#eee0b7",
    selection_fg = "#654735",
    split = "#ddccab",
    ansi = { "#f2e5bc", "#6c782e", "#45707a", "#c14a4a", "#4c7a5d", "#b47109", "#945e80", "#ddccab" },
    brights = { "#e5d5ad", "#6c782e", "#45707a", "#c14a4a", "#4c7a5d", "#b47109", "#945e80", "#e4d6bc" },
    tab_bar = {
      background = "#f2e5bc",
      active_tab = { bg_color = "#7c6f64", fg_color = "#fbf1c7" },
      inactive_tab = { bg_color = "#e5d5ad", fg_color = "#4f3829" },
      inactive_tab_hover = { bg_color = "#f4e8be", fg_color = "#654735" },
      new_tab = { bg_color = "#e5d5ad", fg_color = "#4f3829" },
      new_tab_hover = { bg_color = "#f4e8be", fg_color = "#654735" },
    },
  },

  -- Light - Nightfox-dawn
  ["dawnfox-light"] = {
    foreground = "#575279",
    background = "#faf4ed",
    cursor_bg = "#575279",
    cursor_fg = "#faf4ed",
    cursor_border = "#575279",
    selection_bg = "#d0d8d8",
    selection_fg = "#575279",
    split = "#ebe5df",
    ansi = { "#ebe5df", "#286983", "#907aa9", "#629f81", "#56949f", "#b4637a", "#ea9d34", "#e5e9f0" },
    brights = { "#b1c0c3", "#2d81a3", "#9a80b9", "#618774", "#5ca7b4", "#c26d85", "#eea846", "#e6ebf3" },
    tab_bar = {
      background = "#ebe5df",
      active_tab = { bg_color = "#a8a3b3", fg_color = "#faf4ed" },
      inactive_tab = { bg_color = "#ebe0df", fg_color = "#625c87" },
      inactive_tab_hover = { bg_color = "#ebdfe4", fg_color = "#575279" },
      new_tab = { bg_color = "#ebe0df", fg_color = "#625c87" },
      new_tab_hover = { bg_color = "#ebdfe4", fg_color = "#575279" },
    },
  },

  -- Light - Nightfox-day
  ["dayfox-light"] = {
    foreground = "#3d2b5a",
    background = "#f6f2ee",
    cursor_bg = "#3d2b5a",
    cursor_fg = "#f6f2ee",
    cursor_border = "#3d2b5a",
    selection_bg = "#e7d2be",
    selection_fg = "#3d2b5a",
    split = "#e4dcd4",
    ansi = { "#E3DCD4", "#2848a9", "#6e33ce", "#396847", "#287980", "#ac5402", "#a5222f", "#f2e9e1" },
    brights = { "#acb0c7", "#4863b6", "#8452d5", "#577f63", "#488d93", "#b86e28", "#b3434e", "#f4ece6" },
    tab_bar = {
      background = "#e4dcd4",
      active_tab = { bg_color = "#824d5b", fg_color = "#f6f2ee" },
      inactive_tab = { bg_color = "#dbd1dd", fg_color = "#643f61" },
      inactive_tab_hover = { bg_color = "#d3c7bb", fg_color = "#3d2b5a" },
      new_tab = { bg_color = "#dbd1dd", fg_color = "#643f61" },
      new_tab_hover = { bg_color = "#d3c7bb", fg_color = "#3d2b5a" },
    },
  },

  -- Light - Zenbones
  ["zenbones-light"] = {
    foreground = "#2c363c",
    background = "#f0edec",
    cursor_bg = "#2c363c",
    cursor_fg = "#f0edec",
    cursor_border = "#2c363c",
    selection_bg = "#cbd9e3",
    selection_fg = "#2c363c",
    split = "#a4968f",
    ansi = { "#ddd6d3", "#2c363c", "#4f6c31", "#944927", "#286486", "#88507d", "#3b8992", "#a8334c" },
    brights = { "#cabfb9", "#4f5e68", "#3f5a22", "#803d1c", "#1d5573", "#7b3b70", "#2b747c", "#94253e" },
    tab_bar = {
      background = "#e1dcd9",
      -- TabLineSel clears fg/bg, i.e. falls through to Normal.
      active_tab = { bg_color = "#f0edec", fg_color = "#2c363c" },
      inactive_tab = { bg_color = "#d6cdc9", fg_color = "#596a76" },
      inactive_tab_hover = { bg_color = "#e9e4e2", fg_color = "#2c363c" },
      new_tab = { bg_color = "#d6cdc9", fg_color = "#596a76" },
      new_tab_hover = { bg_color = "#e9e4e2", fg_color = "#2c363c" },
    },
  },

}
