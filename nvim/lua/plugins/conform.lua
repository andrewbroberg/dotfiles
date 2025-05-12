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
            typescript = { "prettier" },
            vue = { "prettier" },
            javascript = { "prettier" },
            typescriptreact = { "prettier" },
            typescriptvue = { "prettier" },
        },
    },
}
