return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = {
            enabled = true,
            preset = {
                header = [[
▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
█ ▄▄▀█ ▄▄▀█▀▄▄▀█ ▄▄▀█ ▄▄█ ▄▄▀█ ▄▄▄████ ▄▀█ ▄▄█▀███▀
█ ▄▄▀█ ▀▀▄█ ██ █ ▄▄▀█ ▄▄█ ▀▀▄█ █▄▀█▀▀█ █ █ ▄▄██ ▀ █
█▄▄▄▄█▄█▄▄██▄▄██▄▄▄▄█▄▄▄█▄█▄▄█▄▄▄▄█▄▄█▄▄██▄▄▄███▄██
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
      ]],
            }
        },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        indent = { enabled = true },
        input = { enabled = false },
        words = { enabled = true },
        terminal = { enabled = true },
        rename = { enabled = true },
        explorer = { enabled = true, replace_netrw = true },
        picker = { enabled = true },
    },
    keys = {
        -- Top Pickers & Explorer
        { "<leader><space>", function() Snacks.picker.smart({ hidden = true, filter = { cwd = true } }) end, desc = "Smart Find Files" },
        { "<leader>,",       function() Snacks.picker.buffers() end,                                         desc = "Buffers" },
        { "<leader>/",       function() Snacks.picker.grep() end,                                            desc = "Grep" },
        { "<leader>:",       function() Snacks.picker.command_history() end,                                 desc = "Command History" },
        { "<leader>n",       function() Snacks.picker.notifications() end,                                   desc = "Notification History" },
        { "<leader>e",       function() Snacks.explorer() end,                                               desc = "File Explorer" },
        -- find
        { "<leader>fb",      function() Snacks.picker.buffers() end,                                         desc = "Buffers" },
        { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,         desc = "Find Config File" },
        { "<leader>ff",      function() Snacks.picker.files() end,                                           desc = "Find Files" },
        { "<leader>fg",      function() Snacks.picker.git_files() end,                                       desc = "Find Git Files" },
        { "<leader>fp",      function() Snacks.picker.projects() end,                                        desc = "Projects" },
        { "<leader>fr",      function() Snacks.picker.recent() end,                                          desc = "Recent" },
        -- git
        { "<leader>gb",      function() Snacks.picker.git_branches() end,                                    desc = "Git Branches" },
        { "<leader>gl",      function() Snacks.picker.git_log() end,                                         desc = "Git Log" },
        { "<leader>gL",      function() Snacks.picker.git_log_line() end,                                    desc = "Git Log Line" },
        { "<leader>gs",      function() Snacks.picker.git_status() end,                                      desc = "Git Status" },
        { "<leader>gS",      function() Snacks.picker.git_stash() end,                                       desc = "Git Stash" },
        { "<leader>gd",      function() Snacks.picker.git_diff() end,                                        desc = "Git Diff (Hunks)" },
        { "<leader>gf",      function() Snacks.picker.git_log_file() end,                                    desc = "Git Log File" },
        -- Grep
        { "<leader>sb",      function() Snacks.picker.lines() end,                                           desc = "Buffer Lines" },
        { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                                    desc = "Grep Open Buffers" },
        { "<leader>sg",      function() Snacks.picker.grep() end,                                            desc = "Grep" },
        { "<leader>sw",      function() Snacks.picker.grep_word() end,                                       desc = "Visual selection or word", mode = { "n", "x" } },
        -- LSP
        { "gd",              function() Snacks.picker.lsp_definitions() end,                                 desc = "Goto Definition" },
        { "gD",              function() Snacks.picker.lsp_declarations() end,                                desc = "Goto Declaration" },
        { "gr",              function() Snacks.picker.lsp_references() end,                                  nowait = true,                     desc = "References" },
        { "gI",              function() Snacks.picker.lsp_implementations() end,                             desc = "Goto Implementation" },
        { "gy",              function() Snacks.picker.lsp_type_definitions() end,                            desc = "Goto T[y]pe Definition" },
        { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                                     desc = "LSP Symbols" },
        { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                           desc = "LSP Workspace Symbols" },

        { "<leader>gg",      function() Snacks.lazygit() end,                                                desc = "Lazygit" },
        { "<c-/>",           function() Snacks.terminal() end,                                               desc = "Toggle Terminal" },
        { "<c-_>",           function() Snacks.terminal() end,                                               desc = "which_key_ignore" },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
                    "<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>uh")
            end,
        })
    end,
}
