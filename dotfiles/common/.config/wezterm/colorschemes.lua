--[[

WezTerm color schemes derived from the Neovim colorschemes in
`set_colorscheme`. One entry per Neovim colorscheme, keyed by
"<nvim_colorscheme>-<nvim_background>" so WezTerm never needs its own
theme name -- picking a Neovim colorscheme picks the terminal palette.

Colors come from each colorscheme itself: `terminal_color_0..15` plus the
Normal/Cursor/Visual/TabLine highlight groups, read out of a headless
Neovim. The exceptions are noted inline.

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
    ansi = { "#181825", "#f38ba8", "#a6e3a1", "#f9e2af", "#89b4fa", "#f5c2e7", "#94e2d5", "#bac2de" },
    brights = { "#313244", "#f38ba8", "#a6e3a1", "#f9e2af", "#89b4fa", "#f5c2e7", "#94e2d5", "#a6adc8" },
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
    ansi = { "#343f44", "#e67e80", "#a7c080", "#dbbc7f", "#7fbbb3", "#d699b6", "#83c092", "#d3c6aa" },
    brights = { "#3d484d", "#ea9597", "#b7cb97", "#e1c896", "#96c7c1", "#ddabc3", "#99cba6", "#dacfb7" },
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
    ansi = { "#32302f", "#ea6962", "#b8c381", "#dfb675", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
    brights = { "#504945", "#ee847e", "#a9b665", "#d8a657", "#94bdb4", "#db9cad", "#9ec298", "#dac8a7" },
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
    ansi = { "#2a2a37", "#c4746e", "#699469", "#c4b28a", "#435965", "#a292a3", "#8ea49e", "#c8c093" },
    brights = { "#363646", "#cc928e", "#72a072", "#d4c196", "#698a9b", "#b4a7b5", "#96ada7", "#d5cd9d" },
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
    ansi = { "#191726", "#eb6f92", "#a3be8c", "#f6c177", "#569fba", "#c4a7e7", "#9ccfd8", "#e0def4" },
    brights = { "#373354", "#f083a2", "#b1d196", "#f9cb8c", "#65b1cd", "#ccb1ed", "#a6dae3", "#e2e0f7" },
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
    ansi = { "#131a24", "#c94f6d", "#81b29a", "#dbc074", "#719cd6", "#9d79d6", "#63cdcf", "#dfdfe0" },
    brights = { "#29394f", "#d16983", "#8ebaa4", "#e0c989", "#86abdc", "#baa1e2", "#7ad5d6", "#e4e4e5" },
    tab_bar = {
      background = "#131a24",
      active_tab = { bg_color = "#71839b", fg_color = "#192330" },
      inactive_tab = { bg_color = "#212e3f", fg_color = "#aeafb0" },
      inactive_tab_hover = { bg_color = "#29394f", fg_color = "#cdcecf" },
      new_tab = { bg_color = "#212e3f", fg_color = "#aeafb0" },
      new_tab_hover = { bg_color = "#29394f", fg_color = "#cdcecf" },
    },
  },

  -- Dark - Nightfox-tera
  ["terafox-dark"] = {
    foreground = "#e6eaea",
    background = "#152528",
    cursor_bg = "#e6eaea",
    cursor_fg = "#152528",
    cursor_border = "#e6eaea",
    selection_bg = "#293e40",
    selection_fg = "#e6eaea",
    split = "#0f1c1e",
    ansi = { "#0f1c1e", "#e85c51", "#7aa4a1", "#fda47f", "#5a93aa", "#ad5c7c", "#a1cdd8", "#ebebeb" },
    brights = { "#254147", "#eb746b", "#8eb2af", "#fdb292", "#73a3b7", "#b97490", "#afd4de", "#eeeeee" },
    tab_bar = {
      background = "#0f1c1e",
      active_tab = { bg_color = "#587b7b", fg_color = "#152528" },
      inactive_tab = { bg_color = "#1d3337", fg_color = "#cbd9d8" },
      inactive_tab_hover = { bg_color = "#254147", fg_color = "#e6eaea" },
      new_tab = { bg_color = "#1d3337", fg_color = "#cbd9d8" },
      new_tab_hover = { bg_color = "#254147", fg_color = "#e6eaea" },
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
    ansi = { "#1b1f26", "#bf616a", "#a3be8c", "#ebcb8b", "#5e81ac", "#b48ead", "#8fbcbb", "#c0c8d8" },
    brights = { "#2e3440", "#c5727a", "#b1c89d", "#efd49f", "#88c0d0", "#be9db8", "#9fc6c5", "#d8dee9" },
    tab_bar = {
      background = "#191d24",
      active_tab = { bg_color = "#242933", fg_color = "#d8dee9" },
      inactive_tab = { bg_color = "#191d24", fg_color = "#c0c8d8" },
      inactive_tab_hover = { bg_color = "#2e3440", fg_color = "#c0c8d8" },
      new_tab = { bg_color = "#191d24", fg_color = "#c0c8d8" },
      new_tab_hover = { bg_color = "#2e3440", fg_color = "#c0c8d8" },
    },
  },

  -- Dark - Rose-pine
  ["rose-pine-moon-dark"] = {
    foreground = "#e0def4",
    background = "#232136",
    cursor_bg = "#56526e",
    cursor_fg = "#e0def4",
    cursor_border = "#56526e",
    selection_bg = "#3b3551",
    selection_fg = "#e0def4",
    split = "#6e6a86",
    ansi = { "#2a273f", "#eb6f92", "#3e8fb0", "#f6c177", "#9ccfd8", "#c4a7e7", "#ea9a97", "#e0def4" },
    brights = { "#393552", "#ef89a6", "#61a3be", "#f8cc8f", "#aed8df", "#cfb7eb", "#eeacaa", "#e5e3f6" },
    tab_bar = {
      background = "#2a273f",
      active_tab = { bg_color = "#393552", fg_color = "#e0def4" },
      inactive_tab = { bg_color = "#2a273f", fg_color = "#908caa" },
      inactive_tab_hover = { bg_color = "#393552", fg_color = "#e0def4" },
      new_tab = { bg_color = "#2a273f", fg_color = "#908caa" },
      new_tab_hover = { bg_color = "#393552", fg_color = "#e0def4" },
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
    ansi = { "#1e1e27", "#d8647e", "#7fa563", "#f3be7c", "#6e94b2", "#bb9dbd", "#aeaed1", "#cdcdcd" },
    brights = { "#2a273f", "#e08398", "#99b782", "#f5cb96", "#8ba9c1", "#c9b1ca", "#bebeda", "#d7d7d7" },
    tab_bar = {
      background = "#1c1c24",
      active_tab = { bg_color = "#333738", fg_color = "#cdcdcd" },
      inactive_tab = { bg_color = "#1c1c24", fg_color = "#606079" },
      inactive_tab_hover = { bg_color = "#252530", fg_color = "#cdcdcd" },
      new_tab = { bg_color = "#1c1c24", fg_color = "#606079" },
      new_tab_hover = { bg_color = "#252530", fg_color = "#cdcdcd" },
    },
  },

  -- Light - Catppuccin
  ["catppuccin-light"] = {
    foreground = "#4c4f69",
    background = "#eff1f5",
    cursor_bg = "#dc8a78",
    cursor_fg = "#eff1f5",
    cursor_border = "#dc8a78",
    selection_bg = "#acb0be",
    selection_fg = "#4c4f69",
    split = "#9ca0b0",
    ansi = { "#e6e9ef", "#d20f39", "#40a02b", "#df8e1d", "#1e66f5", "#ea76cb", "#179299", "#acb0be" },
    brights = { "#ccd0da", "#d20f39", "#40a02b", "#df8e1d", "#1e66f5", "#ea76cb", "#179299", "#bcc0cc" },
    tab_bar = {
      background = "#dce0e8",
      active_tab = { bg_color = "#bcc0cc", fg_color = "#4c4f69" },
      inactive_tab = { bg_color = "#e6e9ef", fg_color = "#6c6f85" },
      inactive_tab_hover = { bg_color = "#ccd0da", fg_color = "#4c4f69" },
      new_tab = { bg_color = "#e6e9ef", fg_color = "#6c6f85" },
      new_tab_hover = { bg_color = "#ccd0da", fg_color = "#4c4f69" },
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
    ansi = { "#f4f0d9", "#f85552", "#8da101", "#dfa000", "#3a94c5", "#df69ba", "#35a77c", "#e6e2cc" },
    brights = { "#e6e2cc", "#f85552", "#8da101", "#dfa000", "#3a94c5", "#df69ba", "#35a77c", "#ebe8d6" },
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
    ansi = { "#f2e5bc", "#c14a4a", "#6c782e", "#b47109", "#45707a", "#945e80", "#4c7a5d", "#ddccab" },
    brights = { "#e5d5ad", "#c14a4a", "#6c782e", "#b47109", "#45707a", "#945e80", "#4c7a5d", "#e4d6bc" },
    tab_bar = {
      background = "#f2e5bc",
      active_tab = { bg_color = "#7c6f64", fg_color = "#fbf1c7" },
      inactive_tab = { bg_color = "#e5d5ad", fg_color = "#4f3829" },
      inactive_tab_hover = { bg_color = "#f4e8be", fg_color = "#654735" },
      new_tab = { bg_color = "#e5d5ad", fg_color = "#4f3829" },
      new_tab_hover = { bg_color = "#f4e8be", fg_color = "#654735" },
    },
  },

  -- Light - Kanagawa-paper-canvas
  ["kanagawa-paper-canvas-light"] = {
    foreground = "#73787d",
    background = "#e1e1de",
    cursor_bg = "#73787d",
    cursor_fg = "#e1e1de",
    cursor_border = "#73787d",
    selection_bg = "#d4cdd4",
    selection_fg = "#73787d",
    split = "#9ba1bf",
    ansi = { "#d1cfc5", "#c27672", "#7b958e", "#a7956a", "#809ba7", "#9e7e98", "#7e8faf", "#aeaea6" },
    brights = { "#d8d8d2", "#c68582", "#84a098", "#b29f71", "#91b0bd", "#a989a3", "#8a9ab8", "#b6b6ae" },
    tab_bar = {
      background = "#cbc8bc",
      active_tab = { bg_color = "#e1e1de", fg_color = "#73787d" },
      -- Exception: TabLine's own fg (#8e8a80) barely clears its bg here, so the
      -- inactive label uses Normal's fg; the bg still separates it from active.
      inactive_tab = { bg_color = "#cbc8bc", fg_color = "#73787d" },
      inactive_tab_hover = { bg_color = "#d8d8d2", fg_color = "#73787d" },
      new_tab = { bg_color = "#cbc8bc", fg_color = "#73787d" },
      new_tab_hover = { bg_color = "#d8d8d2", fg_color = "#73787d" },
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
    ansi = { "#ebe5df", "#b4637a", "#629f81", "#ea9d34", "#286983", "#907aa9", "#56949f", "#e5e9f0" },
    brights = { "#b1c0c3", "#c26d85", "#618774", "#eea846", "#2d81a3", "#9a80b9", "#5ca7b4", "#e6ebf3" },
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
    ansi = { "#E3DCD4", "#a5222f", "#396847", "#ac5402", "#2848a9", "#6e33ce", "#287980", "#f2e9e1" },
    brights = { "#d3c7bb", "#b3434e", "#577f63", "#b86e28", "#4863b6", "#8452d5", "#488d93", "#f4ece6" },
    tab_bar = {
      background = "#e4dcd4",
      active_tab = { bg_color = "#824d5b", fg_color = "#f6f2ee" },
      inactive_tab = { bg_color = "#dbd1dd", fg_color = "#643f61" },
      inactive_tab_hover = { bg_color = "#d3c7bb", fg_color = "#3d2b5a" },
      new_tab = { bg_color = "#dbd1dd", fg_color = "#643f61" },
      new_tab_hover = { bg_color = "#d3c7bb", fg_color = "#3d2b5a" },
    },
  },

  -- Light - Rose-pine
  ["rose-pine-dawn-light"] = {
    foreground = "#464261",
    background = "#faf4ed",
    cursor_bg = "#cecacd",
    cursor_fg = "#464261",
    cursor_border = "#cecacd",
    selection_bg = "#eae2e3",
    selection_fg = "#464261",
    split = "#9893a5",
    ansi = { "#f2e9e1", "#b4637a", "#286983", "#ea9d34", "#56949f", "#907aa9", "#d7827e", "#464261" },
    brights = { "#d3c7bb", "#b4637a", "#286983", "#ea9d34", "#56949f", "#907aa9", "#d7827e", "#38354e" },
    tab_bar = {
      background = "#fffaf3",
      active_tab = { bg_color = "#f2e9e1", fg_color = "#464261" },
      inactive_tab = { bg_color = "#fffaf3", fg_color = "#797593" },
      inactive_tab_hover = { bg_color = "#f2e9e1", fg_color = "#464261" },
      new_tab = { bg_color = "#fffaf3", fg_color = "#797593" },
      new_tab_hover = { bg_color = "#f2e9e1", fg_color = "#464261" },
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
    ansi = { "#ddd6d3", "#a8334c", "#4f6c31", "#944927", "#286486", "#88507d", "#3b8992", "#2c363c" },
    brights = { "#cabfb9", "#94253e", "#3f5a22", "#803d1c", "#1d5573", "#7b3b70", "#2b747c", "#4f5e68" },
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
