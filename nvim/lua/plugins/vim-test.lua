return {
  'vim-test/vim-test',

  keys = {
    { '<Leader>tn', ':silent TestNearest<CR>' },
    { '<Leader>tf', ':silent TestFile<CR>' },
    { '<Leader>ts', ':silent TestSuite<CR>' },
    { '<Leader>tl', ':silent TestLast<CR>' },
    { '<Leader>tv', ':silent TestVisit<CR>' },
  },

  config = function()
    local pane

    local function pane_alive()
      return pane and vim.system({ 'herdr', 'pane', 'get', pane }):wait().code == 0
    end

    vim.g['test#custom_strategies'] = {
      herdr = function(cmd)
        if not pane_alive() then
          local out = vim.system({
            'herdr', 'pane', 'split', '--current',
            '--direction', 'down', '--ratio', '0.25', '--no-focus',
          }):wait()
          pane = vim.json.decode(out.stdout).result.pane.pane_id
        end
        vim.system({ 'herdr', 'pane', 'run', pane, cmd })
      end,
    }

    vim.g['test#strategy'] = vim.env.HERDR_PANE_ID and 'herdr' or 'basic'
  end,
}
