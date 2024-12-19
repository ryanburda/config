local T = {}

function T.setup()

    local cmp = require("cmp")
    local lspkind = require('lspkind')

    cmp.setup({
        enabled = true,
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        experimental = {
            ghost_text = false,
        },
        window = {
            completion = cmp.config.window.bordered({
                col_offset = 12,
                scrolloff = 4,
            }),
            documentation = cmp.config.window.bordered({max_width = 100}),
        },
        completion = {
            completeopt = 'menu,menuone,noinsert',
        },
        mapping = {
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-l>'] = cmp.mapping.confirm { select = true },
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lsp', },
            { name = 'luasnip', },
            { name = 'buffer', },
            { name = 'path', },
            { name = 'nvim_lua', },
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
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        },
        view = {
            entries = { name = 'custom', selection_order = 'near_cursor' }
        },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        }),
        view = {
            entries = { name = 'custom', selection_order = 'near_cursor' }
        },
    })

end

return T
