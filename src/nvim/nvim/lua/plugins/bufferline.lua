local T = {}

T.setup = function()
    vim.opt.termguicolors = true
    require('bufferline').setup{}
end

return T
