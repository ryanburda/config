local T = {}

function T.setup()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')

    -- Set header
    dashboard.section.header.val = {
      '                                    ',
      '  ███╗   ██╗██╗   ██╗██╗███╗   ███╗ ',
      '  ████╗  ██║██║   ██║██║████╗ ████║ ',
      '  ██╔██╗ ██║██║   ██║██║██╔████╔██║ ',
      '  ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
      '  ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
      '  ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button( '<leader>aa', 'File Tree'             , ':NvimTreeFocus<CR>'),
      dashboard.button( '<leader>ff', 'Find File'             , ':Telescope find_files<CR>'),
      dashboard.button( '<leader>fg', 'GREP'                  , ':Telescope live_grep<CR>'),
      dashboard.button( '<leader>fe', 'File Explorer (Recent)', ':Telescope oldfiles<CR>'),
      dashboard.button( '<leader>f?', 'Key Map'               , ':Telescope keymaps<CR>'),
      dashboard.button( 'q'         , 'Quit'                  , ':qa<CR>'),
    }

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[
      autocmd FileType alpha setlocal nofoldenable
    ]])
end

return T
