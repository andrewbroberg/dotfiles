return {
    "ibhagwan/fzf-lua",
    enabled = false,
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("fzf-lua").setup({
            winopts = {
                preview = {
                    horizontal = "right:40%"
                }
            }
        })
        require('fzf-lua').register_ui_select()
    end,
    keys = {
        {
            "<leader>,",
            function()
                require('fzf-lua').buffers()
            end,
            desc = "Switch Buffer",
        },
        {
            "<leader>/",
            function()
                require('fzf-lua').live_grep()
            end,
            desc = "Grep (Root Dir)"
        },
        {
            "<leader><space>",
            function()
                require('fzf-lua').files()
            end,
            desc = "Find Files (Root Dir)"
        },

        {
            "<leader>ff",
            function()
                require('fzf-lua').files()
            end,
            desc = "Find Files (Root Dir)"
        },
        {
            "<leader>ss",
            function()
                require("fzf-lua").lsp_document_symbols({})
            end,
            desc = "Goto Symbol",
        },
        {
            "<leader>sS",
            function()
                require("fzf-lua").lsp_live_workspace_symbols()
            end,
            desc = "Goto Symbol (Workspace)",
        },
    },
}
