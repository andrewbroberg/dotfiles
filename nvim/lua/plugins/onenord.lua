return {
    'rmehri01/onenord.nvim',
    config = function()
        require('onenord').setup()
        vim.cmd.colorscheme 'onenord'
    end
}
