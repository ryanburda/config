local T = {}

T.setup = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')

    -- Set header
    dashboard.section.header.val = {
      '                                                     ',
      '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
      '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
      '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
      '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
      '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
      '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
      '                                                     ',
      '  > ' .. os.getenv('PWD'),
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button( '<leader>ff', 'Find File'  , ':Telescope find_files<CR>'),
      dashboard.button( '<leader>fg', 'GREP'       , ':Telescope live_grep<CR>'),
      dashboard.button( '<leader>fl', 'Last Opened', ':Telescope oldfiles<CR>'),
      dashboard.button( '<leader>fk', 'Key Map'    , ':Telescope keymaps<CR>'),
      dashboard.button( 'n'         , 'New File'   , ':ene <BAR> startinsert <CR>'),
      dashboard.button( 'q'         , 'Quit NVIM'  , ':qa<CR>'),
    }

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[
      autocmd FileType alpha setlocal nofoldenable
    ]])
end

return T
