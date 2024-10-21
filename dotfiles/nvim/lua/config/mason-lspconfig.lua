local T = {}


function T.setup()

    require("mason-lspconfig").setup({
        ensure_installed = {
            "bashls",
            "dockerls",
            "gopls",
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

    require("mason-lspconfig").setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        -- function (server_name) -- default handler (optional)
        --     require("lspconfig")[server_name].setup({
        --         capabilities = capabilities
        --     })
        -- end,
        -- Next, you can provide a dedicated handler for specific servers.
        ["lua_ls"] = function ()
            require("neodev").setup({
                -- add any options here, or leave empty to use the default settings
            })

            -- then setup your lsp server as usual
            local lspconfig = require('lspconfig')

            -- example to setup lua_ls and enable call snippets
            lspconfig.lua_ls.setup({
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

        ["gopls"] = function  ()
            require("lspconfig")["gopls"].setup({
                on_attach = function(client, bufnr)
                    require('gopls').on_attach(client, bufnr)
                end,
                capabilities = capabilities,
                cmd = {"gopls"},
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true
                        },
                    },
                },
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
                    vim.keymap.set('n', '<M-m>', ":lua require('dap-python').test_method()<cr>", { buffer = bufnr })
                    vim.keymap.set('n', '<M-,>', ":lua require('dap-python').test_class()<cr>", { buffer = bufnr })
                    vim.keymap.set('n', '<M-.>', ":lua require('dap-python').debug_selection()<cr>", { buffer = bufnr })
                end,
                capabilities = capabilities
            })
        end,

        ["yamlls"] = function ()
            require("lspconfig")["yamlls"].setup({
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
                end,
                settings = {
                    sqls = {
                        connections = require('config.sqls').get_all_connections()
                    },
                },
            }
        end,

    })

end

return T
