local T = {}

function T.setup()

    local luasnip = require("luasnip")
    local cmp = require("cmp")
    local lspkind = require('lspkind')

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local is_whitespace = function()
        -- returns true if the character under the cursor is whitespace.
        local col = vim.fn.col('.') - 1
        local line = vim.fn.getline('.')
        local char_under_cursor = string.sub(line, col, col)

        if col == 0 or string.match(char_under_cursor, '%s') then
            return true
        else
            return false
        end
    end

    local is_comment = function()
        -- uses treesitter to determine if cursor is currently in a comment.
        local context = require("cmp.config.context")
        return context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment")
    end

    cmp.setup({
        enabled = function()
            if is_comment() or is_whitespace() then
                return false
            else
                return true
            end
        end,
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
        completion = {
            completeopt = 'menu,menuone,noinsert',
        },
        mapping = {
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-l>'] = cmp.mapping.confirm { select = true },
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<C-e>'] = cmp.mapping.abort(),
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
