return {
    "nvim-neotest/neotest",
    lazy = false,
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "olimorris/neotest-phpunit",
        "nvim-neotest/neotest-jest",
        "V13Axel/neotest-pest",
    },
    config = function()
        require("neotest").setup({
            highlights = {
                adapter_name = "Title",
                border = "VertSplit",
                dir = "Directory",
                expand_marker = "Normal",
                failed = "DiagnosticError",
                file = "Normal",
                focused = "Underline",
                indent = "Normal",
                marked = "Bold",
                namespace = "Title",
                passed = "DiagnosticOK",
                running = "DiagnosticInfo",
                select_win = "Title",
                skipped = "DiagnosticWarn",
                target = "NeotestTarget",
                test = "String",
                unknown = "Normal",
                watching = "DiagnosticWarn",
            },
            adapters = {
                require("neotest-phpunit")({
                    root_ignore_files = { "tests/Pest.php" },
                    filter_dirs = { "vendor" },
                }),
                require("neotest-jest")({
                    jestCommand = "npm test --",
                    env = { CI = true },
                    cwd = function(path)
                        return vim.fn.getcwd()
                    end,
                }),
                require("neotest-pest"),
            },
        })
    end,
    -- stylua: ignore
    keys = {
        { "<leader>t",  "",                                                                                 desc = "+test" },
        { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end,                      desc = "Run File (Neotest)" },
        { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end,                            desc = "Run All Test Files (Neotest)" },
        { "<leader>tr", function() require("neotest").run.run() end,                                        desc = "Run Nearest (Neotest)" },
        { "<leader>tl", function() require("neotest").run.run_last() end,                                   desc = "Run Last (Neotest)" },
        { "<leader>ts", function() require("neotest").summary.toggle() end,                                 desc = "Toggle Summary (Neotest)" },
        { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
        { "<leader>tO", function() require("neotest").output_panel.toggle() end,                            desc = "Toggle Output Panel (Neotest)" },
        { "<leader>tS", function() require("neotest").run.stop() end,                                       desc = "Stop (Neotest)" },
        { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end,                 desc = "Toggle Watch (Neotest)" },
    },
}
