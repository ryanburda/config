local T = {}

function T.setup()

    require("mason-lspconfig").setup({
        ensure_installed = {
            "bashls",
            "dockerls",
            "jsonls",
            "lua_ls",
            "pyright",
            "rust_analyzer",
            "sqls",
            "yamlls"
        },
        automatic_installation = true,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local function on_attach(_, bufnr)
        --vim.keymap.set('i', '<C-i>'     , '<cmd>lua vim.lsp.buf.hover()<CR>', {desc = 'LSP: Hover', buffer = bufnr})
        vim.keymap.set('n', '<leader>jh', '<cmd>lua vim.lsp.buf.hover()<CR>', {desc = 'LSP: Hover', buffer = bufnr})
        vim.keymap.set('n', '<leader>jj', '<cmd>lua vim.lsp.buf.definition()<CR>', {desc = 'LSP: jump to definition', buffer = bufnr})
        vim.keymap.set('n', '<leader>jt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {desc = 'LSP: jump to type', buffer = bufnr})
        vim.keymap.set('n', '<leader>jk', '<cmd>lua vim.lsp.buf.references()<CR>', {desc = 'LSP: references kwickfix', buffer = bufnr})
        vim.keymap.set('n', '<leader>jr', '<cmd>lua vim.lsp.buf.rename()<CR>', {desc = 'LSP: rename', buffer = bufnr})
        vim.keymap.set({'n', 'v'}, '<leader>ja', '<cmd>lua vim.lsp.buf.code_action()<CR>', {desc = 'LSP: code action', buffer = bufnr})
    end

    require("mason-lspconfig").setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup({
                on_attach = on_attach,
                capabilities = capabilities
            })
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        ["lua_ls"] = function ()
            require("neodev").setup({
                -- add any options here, or leave empty to use the default settings
            })

            -- then setup your lsp server as usual
            local lspconfig = require('lspconfig')

            -- example to setup lua_ls and enable call snippets
            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace"
                        },
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { 'require', 'vim', },
                            telemetry = {
                                enable = false
                            },
                        },
                    }
                }
            })
        end,

        ["pyright"] = function ()
            -- set up the python debugger
            local handle = assert(io.popen("which python"))
            local result = handle:read("*all")
            handle:close()

            require('dap-python').setup(result)
            require('dap-python').test_runner = 'pytest'

            require("lspconfig")["pyright"].setup({
                on_attach = function (_, bufnr)
                    on_attach(_, bufnr)
                    vim.keymap.set('n', '<M-m>', ":lua require('dap-python').test_method()<cr>", { buffer = bufnr })
                    vim.keymap.set('n', '<M-,>', ":lua require('dap-python').test_class()<cr>", { buffer = bufnr })
                    vim.keymap.set('n', '<M-.>', ":lua require('dap-python').debug_selection()<cr>", { buffer = bufnr })
                end,
                capabilities = capabilities
            })
        end,

        ["rust_analyzer"] = function ()
            local rt = require("rust-tools")

            -- Must install https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb
            local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.9.0/'
            local codelldb_path = extension_path .. 'adapter/codelldb'
            local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'  -- MacOS
            --local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'  -- Linux

            rt.setup({
                server = {
                    on_attach = function(_, bufnr)
                        on_attach(_, bufnr)
                        vim.keymap.set("n", "<M-m>", rt.hover_actions.hover_actions, { buffer = bufnr })
                        vim.keymap.set("n", "<M-,>", rt.code_action_group.code_action_group, { buffer = bufnr })
                    end,
                },
                dap = {
                    adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
                },
            })
        end,

        ["yamlls"] = function ()
            require("lspconfig")["yamlls"].setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    yaml = {
                        schemas = {
                            ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.y*ml",
                            ["https://json.schemastore.org/drone.json"] = ".drone.y*ml",
                        }
                    }
                }
            })
        end,

        ["sqls"] = function ()
            require('lspconfig').sqls.setup{
                on_attach = function(client, bufnr)
                    require('sqls').on_attach(client, bufnr)
                end
            }
        end,

    })

end

return T
