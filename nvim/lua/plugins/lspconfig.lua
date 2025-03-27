-- Language Server Protocol

return {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'b0o/schemastore.nvim',
        'saghen/blink.cmp',
    },
    config = function()
        -- Setup Mason to automatically install LSP servers
        require('mason').setup({
            ui = {
                height = 0.8,
            },
        })

        local capabilities = require('blink.cmp').get_lsp_capabilities()

        require('mason-lspconfig').setup({ automatic_installation = true })

        require('lspconfig').bashls.setup({
            capabilities = capabilities
        })

        -- YAML
        require('lspconfig').yamlls.setup({
            capabilities = capabilities
        })

        -- PHP
        require('lspconfig').intelephense.setup({
            commands = {
                IntelephenseIndex = {
                    function()
                        vim.lsp.buf.execute_command({ command = 'intelephense.index.workspace' })
                    end,
                },
            },
            capabilities = capabilities
        })

        require('lspconfig').phpactor.setup({
            capabilities = capabilities,

            on_attach = function(client, bufnr)
                client.server_capabilities.completionProvider = false
                client.server_capabilities.hoverProvider = false
                client.server_capabilities.implementationProvider = false
                client.server_capabilities.referencesProvider = false
                client.server_capabilities.renameProvider = false
                client.server_capabilities.selectionRangeProvider = false
                client.server_capabilities.signatureHelpProvider = false
                client.server_capabilities.typeDefinitionProvider = false
                client.server_capabilities.workspaceSymbolProvider = false
                client.server_capabilities.definitionProvider = false
                client.server_capabilities.documentHighlightProvider = false
                client.server_capabilities.documentSymbolProvider = false
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,

            init_options = {
                ["language_server_worse_reflection.inlay_hints.enable"] = true,
                ["language_server_worse_reflection.inlay_hints.params"] = true,
                ["language_server_worse_reflection.inlay_hints.types"] = false,
            },

            handlers = {
                ['textDocument/publishDiagnostics'] = function() end
            }
        })

        -- Vue, JavaScript, TypeScript
        require('lspconfig').volar.setup({
            on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
            capabilities = capabilities,
        })

        require('lspconfig').ts_ls.setup({
            init_options = {
                plugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = vim.fn.expand("~/.nvm/versions/node/v23.9.0/lib/node_modules/@vue/typescript-plugin"),
                        languages = { "javascript", "typescript", "vue" },
                    },
                },
            },
            filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
                "vue",
            },
        })

        -- Antlers
        require('lspconfig').antlersls.setup({ capabilities = capabilities })

        -- Tailwind CSS
        require('lspconfig').tailwindcss.setup({ capabilities = capabilities })

        -- JSON
        require('lspconfig').jsonls.setup({
            capabilities = capabilities,
            settings = {
                json = {
                    schemas = require('schemastore').json.schemas(),
                },
            },
        })

        -- Lua
        require('lspconfig').lua_ls.setup({
            settings = {
                Lua = {
                    runtime = { version = 'LuaJIT' },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            '${3rd}/luv/library',
                            unpack(vim.api.nvim_get_runtime_file('', true)),
                        },
                    }
                }
            }
        })

        -- Keymaps
        vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
        vim.keymap.set('n', '<Leader>lr', ':LspRestart<CR>', { silent = true })
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
        vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

        -- Diagnostic configuration
        vim.diagnostic.config({
            virtual_text = true,
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
