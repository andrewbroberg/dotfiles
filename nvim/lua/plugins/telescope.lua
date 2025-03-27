return {
    'nvim-telescope/telescope.nvim',
    enabled = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'nvim-telescope/telescope-live-grep-args.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
    },
    config = function()
        require('telescope').setup({
            defaults = {
                file_ignore_patterns = { '.git/' },
            },
            pickers = {
                find_files = {
                    -- hidden = true,
                    -- no_ignore = true,
                },
            },
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
            }
        })

        require('telescope').load_extension('ui-select')
        require('telescope').load_extension('fzf')
    end,
    keys = {
        {
            "<leader>,",
            "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
            desc = "Switch Buffer",
        },
        { "<leader>/",       "<cmd>Telescope live_grep<cr>",       desc = "Grep (Root Dir)" },
        { "<leader>:",       "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader><space>", "<cmd>Telescope find_files<cr>",      desc = "Find Files (Root Dir)" },
        -- find
        {
            "<leader>fb",
            "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
            desc = "Buffers",
        },
        { "<leader>fg", "<cmd>Telescope git_files<cr>",  desc = "Find Files (git-files)" },
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (Root Dir)" },
        {
            "<leader>fF",
            function()
                require('telescope.builtin').find_files({
                    hidden = true,
                    no_ignore = true,
                })
            end
            ,
            desc = "Find All Files (Including Hidden)"
        },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                  desc = "Recent" },
        -- git
        { "<leader>gc", "<cmd>Telescope git_commits<CR>",               desc = "Commits" },
        { "<leader>gs", "<cmd>Telescope git_status<CR>",                desc = "Status" },
        -- search
        { '<leader>s"', "<cmd>Telescope registers<cr>",                 desc = "Registers" },
        { "<leader>sa", "<cmd>Telescope autocommands<cr>",              desc = "Auto Commands" },
        { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
        { "<leader>sc", "<cmd>Telescope command_history<cr>",           desc = "Command History" },
        { "<leader>sC", "<cmd>Telescope commands<cr>",                  desc = "Commands" },
        { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>",       desc = "Document Diagnostics" },
        { "<leader>sD", "<cmd>Telescope diagnostics<cr>",               desc = "Workspace Diagnostics" },
        { "<leader>sg", "<cmd>Telescope live_grep<cr>",                 desc = "Grep (Root Dir)" },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>",                 desc = "Help Pages" },
        { "<leader>sH", "<cmd>Telescope highlights<cr>",                desc = "Search Highlight Groups" },
        { "<leader>sj", "<cmd>Telescope jumplist<cr>",                  desc = "Jumplist" },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>",                   desc = "Key Maps" },
        { "<leader>sl", "<cmd>Telescope loclist<cr>",                   desc = "Location List" },
        { "<leader>sM", "<cmd>Telescope man_pages<cr>",                 desc = "Man Pages" },
        { "<leader>sm", "<cmd>Telescope marks<cr>",                     desc = "Jump to Mark" },
        { "<leader>so", "<cmd>Telescope vim_options<cr>",               desc = "Options" },
        { "<leader>sR", "<cmd>Telescope resume<cr>",                    desc = "Resume" },
        { "<leader>sq", "<cmd>Telescope quickfix<cr>",                  desc = "Quickfix List" },
        { "<leader>sg", "<cmd>Telescope grep_string<cr>",               desc = "Grep for string" },
        {
            "<leader>ss",
            function()
                require("telescope.builtin").lsp_document_symbols({})
            end,
            desc = "Goto Symbol",
        },
        {
            "<leader>sS",
            function()
                require("telescope.builtin").lsp_dynamic_workspace_symbols({})
            end,
            desc = "Goto Symbol (Workspace)",
        },
    },
}
