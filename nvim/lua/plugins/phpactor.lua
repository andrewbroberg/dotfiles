-- PHP Refactoring Tools

return {
  "gbprod/phpactor.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig"
  },
  opts = {
    install = {
      -- despite being under "install" this path is used when running RPC commands.
      bin = vim.fn.stdpath("data") .. "/mason/packages/phpactor/phpactor",
    },
    lspconfig = {
      enabled = false,
    }
  },
}
