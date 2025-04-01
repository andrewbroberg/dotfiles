return {
    "stevearc/conform.nvim",
    enabled = true,
    lazy = false,
    opts = {
        format_on_save = {
            timeout_ms = 1000,
            lsp_format = "never",
        },
        formatters_by_ft = {
            lua = { "stylua" },
            php = { "pint" },
            typescript = { "eslint", stop_after_first = true },
            vue = { "eslint", stop_after_first = true },
            javascript = { "eslint", stop_after_first = true },
            typescriptreact = { "eslint", stop_after_first = true },
        },
    },
}
