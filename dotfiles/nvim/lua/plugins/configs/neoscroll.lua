local T = {}

function T.setup()

    require('neoscroll').setup({
        mappings = {'<C-u>', '<C-d>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
        time = 2
    })

    local t = {}
    -- Syntax: t[keys] = {function, {function arguments}}
    t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '60'}}
    t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '60'}}
    t['<C-y>'] = {'scroll', {'-0.10', 'false', '60'}}
    t['<C-e>'] = {'scroll', { '0.10', 'false', '60'}}
    t['zt']    = {'zt', {'60'}}
    t['zz']    = {'zz', {'60'}}
    t['zb']    = {'zb', {'60'}}

    require('neoscroll.config').set_mappings(t)

end

return T
