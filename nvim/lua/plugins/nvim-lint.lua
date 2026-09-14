return {
  'mfussenegger/nvim-lint',
  config = function()
    local lint = require('lint')

    lint.linters.jsonl = {
      cmd = 'jq',
      args = { 'empty' },
      stdin = true,
      stream = 'stderr',
      ignore_exitcode = true,
      parser = require('lint.parser').from_pattern(
        '(.+) at line (%d+), column (%d+)',
        { 'message', 'lnum', 'col' }
      ),
    }

    lint.linters_by_ft = {
      javascript = { 'eslint' },
      vue = { 'eslint' },
      javascriptreact = { 'eslint' },
      typescript = { 'eslint' },
      typescriptreact = { 'eslint' },
      jsonl = { 'jsonl' },
    }

    -- Configure eslint_d to use flat config (eslint.config.js)
    lint.linters.eslint_d.args = {
      '--no-warn-ignored',
      '--format',
      'json',
      '--stdin',
      '--stdin-filename',
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
