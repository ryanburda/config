local T = {}

function T.setup()

    require('neoscroll').setup({
        mappings = {'<C-u>', '<C-d>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
        time = 10
    })

    local t = {}
    -- Syntax: t[keys] = {function, {function arguments}}
    t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '100'}}
    t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '100'}}
    t['<C-y>'] = {'scroll', {'-0.10', 'false', '100'}}
    t['<C-e>'] = {'scroll', { '0.10', 'false', '100'}}
    t['zt']    = {'zt', {'100'}}
    t['zz']    = {'zz', {'100'}}
    t['zb']    = {'zb', {'100'}}

    require('neoscroll.config').set_mappings(t)

end

return T
