local T = {}

function T.setup()

    local cmp = require('cmp')
    local lspkind = require('lspkind')

    cmp.setup({
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        experimental = {
            ghost_text = true,
        },
        window = {
            completion = cmp.config.window.bordered({
                scrolloff = 4,
            }),
            documentation = cmp.config.window.bordered({max_width = 100}),
        },
        view = {
            entries = { name = 'custom', selection_order = 'bottom_up' }
        },
        completion = {
            completeopt = 'menu,menuone,noinsert',
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lsp', },
            { name = 'luasnip', },
            { name = 'buffer', },
            { name = 'path', },
            { name = 'nvim_lua', },
            { name = 'cmdline', },
            { name = 'nvim_lua', },
            { name = "copilot", group_index = 2, },
        }),
        formatting = {
            format = lspkind.cmp_format({
                mode = "symbol_text",
                max_width = 75,
                symbol_map = { Copilot = "" }
            })
        },
        sorting = {
            priority_weight = 2,
            comparators = {
                -- Below is the default comparitor list and order for nvim-cmp
                cmp.config.compare.offset,
                -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                cmp.config.compare.exact,
                cmp.config.compare.score,
                cmp.config.compare.recently_used,
                cmp.config.compare.locality,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
            { name = 'buffer' },
        })
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer', max_item_count = 8 }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })

end

return T
