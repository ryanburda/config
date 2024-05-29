local T = {}

function T.setup()

    local neoscroll = require('neoscroll')
    local keymap = {
      ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 10 }) end;
      ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 10 }) end;
      ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 10 }) end;
      ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 10 }) end;
      ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor=false; duration = 100 }) end;
      ["<C-e>"] = function() neoscroll.scroll(0.1, { move_cursor=false; duration = 100 }) end;
      ["zt"]    = function() neoscroll.zt({ half_screen_duration = 10, half_win_duration = 10 }) end;
      ["zz"]    = function() neoscroll.zz({ half_screen_duration = 10, half_win_duration = 10}) end;
      ["zb"]    = function() neoscroll.zb({ half_screen_duration = 10, half_win_duration = 10 }) end;
      ["G"]     = function() neoscroll.G({ half_screen_duration = 10, half_win_duration = 10 }) end;
      ["gg"]    = function() neoscroll.gg({ half_screen_duration = 10, half_win_duration = 10 }) end;
    }
    local modes = { 'n', 'v', 'x' }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end

end

return T
