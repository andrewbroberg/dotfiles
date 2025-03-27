return {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "rcarriga/nvim-dap-ui"
    },
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'
        dapui.setup()

        -- Open and close dap-ui automatically
        dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close()
        end

        -- Add explicit handling for manual termination
        dap.listeners.before.disconnect['dapui_config'] = function()
            dapui.close()
        end
        dap.listeners.before.terminate['dapui_config'] = function()
            dapui.close()
        end

        vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
        vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
        vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
        vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
        vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
        vim.keymap.set('n', '<leader>dB', function()
            dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end, { desc = 'Debug: Set Breakpoint with Condition' })
        vim.keymap.set('n', '<leader>lp', function()
            dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
        end, { desc = 'Debug: Log Point' })
        vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'Debug: Open REPL' })
        vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Debug: Run Last' })

        require("mason-nvim-dap").setup({
            automatic_installation = true,
            autmatic_setup = true,
            handlers = {
                function(config)
                    require('mason-nvim-dap').default_setup(config)
                end,
                php = function(config)
                    config.configurations = {
                        {
                            type = 'php',
                            request = 'launch',
                            name = "Listen for XDebug",
                            port = 9003,
                            log = true,
                            cwd = '${workspaceFolder}',
                            hostname = '0.0.0.0',
                        }
                    }

                    require('mason-nvim-dap').default_setup(config) -- don't forget this!
                end,

            },
            ensure_installed = { "php" }
        })
    end
}
