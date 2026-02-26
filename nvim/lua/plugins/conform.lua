return {
    "stevearc/conform.nvim",
    enabled = true,
    lazy = false,
    opts = {
        format_on_save = {
            timeout_ms = 1000,
            lsp_fallback = false,
        },
        formatters_by_ft = {
            lua = { "stylua" },
            php = { "pint" },
            typescript = { "eslint_d" },
            vue = { "eslint_d" },
            javascript = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            typescriptvue = { "eslint_d" },
        },
    },
}
