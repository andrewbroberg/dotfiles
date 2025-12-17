-- Language Server Protocol

return {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
        'mason-org/mason.nvim',
        'mason-org/mason-lspconfig.nvim',
        'b0o/schemastore.nvim',
    },
    config = function()
        -- Setup Mason to automatically install LSP servers
        require('mason').setup({
            ui = {
                height = 0.8,
            },
        })

        local capabilities = require('blink.cmp').get_lsp_capabilities()

        require('mason-lspconfig').setup({
            automatic_installation = true
        })

        vim.lsp.config("bashls", {
            cmd = { "bash-language-server", "start" },
            filetypes = { "sh", "bash" },
            capabilities = capabilities
        })

        -- YAML
        vim.lsp.config("yamlls", {
            cmd = { "yaml-language-server", "--stdio" },
            filetypes = { "yaml", "yaml.docker-compose" },
            capabilities = capabilities
        })

        vim.lsp.config("intelephense", {
            cmd = { "intelephense", "--stdio" },
            filetypes = { "php" },
            capabilities = capabilities,
            commands = {
                IntelephenseIndex = {
                    function()
                        vim.lsp.buf.execute_command({ command = 'intelephense.index.workspace' })
                    end,
                },
            },
            settings = {
                intelephense = {
                    telemetry = {
                        enabled = false
                    },
                    files = {
                        maxSize = 5000000
                    }
                },
                environment = {
                    phpVersion = '8.4.10'
                }
            },
        })

        vim.lsp.config("vtsls", {
            filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
            settings = {
                vtsls = { tsserver = { globalPlugins = {} } },
                typescript = {
                    inlayHints = {
                        parameterNames = { enabled = "literals" },
                        parameterTypes = { enabled = true },
                        variableTypes = { enabled = true },
                        propertyDeclarationTypes = { enabled = true },
                        functionLikeReturnTypes = { enabled = true },
                        enumMemberValues = { enabled = true },
                    },
                },
            },
            before_init = function(_, config)
                table.insert(config.settings.vtsls.tsserver.globalPlugins, {
                    name = "@vue/typescript-plugin",
                    location = vim.fn.expand(
                        "$MASON/packages/vue-language-server/node_modules/@vue/language-server"
                    ),
                    languages = { "vue" },
                    configNamespace = "typescript",
                    enableForWorkspaceTypeScriptVersions = true,
                })
            end,
            on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
        })

        -- Antlers
        vim.lsp.config("antlersls", {
            cmd = { "antlersls", "--stdio" },
            filetypes = { "antlers", "html" },
            capabilities = capabilities
        })

        -- Tailwind CSS
        vim.lsp.config("tailwindcss", {
            cmd = { "tailwindcss-language-server", "--stdio" },
            filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "php", "blade" },
            capabilities = capabilities
        })

        -- JSON
        vim.lsp.config("jsonls", {
            cmd = { "vscode-json-language-server", "--stdio" },
            filetypes = { "json", "jsonc" },
            capabilities = capabilities,
            settings = {
                json = {
                    schemas = require('schemastore').json.schemas(),
                },
            },
        })

        vim.lsp.config("lua_ls", {
            on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
            settings = {
                Lua = {
                    workspace = {
                        checkThirdParty = false,
                    },
                    completion = {
                        callSnippet = "Replace",
                    },
                    telemetry = {
                        enable = false,
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })

        -- Keymaps
        vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
        vim.keymap.set('n', '<Leader>lr', ':LspRestart<CR>', { silent = true })
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
        vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

        -- Diagnostic configuration
        vim.diagnostic.config({
            virtual_text = false,

            float = {
                source = true,
            }
        })

        -- Sign configuration
        vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
        vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
        vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
        vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
    end,
}
