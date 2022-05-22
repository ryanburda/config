local T = {}

function T.setup()
    vim.opt.termguicolors = true
    require('bufferline').setup{}
end

return T
