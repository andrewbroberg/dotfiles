return {
    'phpactor/phpactor',

    build = 'composer install --no-dev --optimize-autoloader',

    ft = 'php',

    keys = {
        { '<Leader>p', ':PhpactorContextMenu<CR>' },
        { '<Leader>u', ':call phpactor#ImportClass()<CR>' },
        { '<leader>rc', ':call phpactor#ExtractConstant()<cr>', mode = 'v' },                    -- Extract a constant
        { '<leader>re', ':<c-u>call phpactor#ExtractExpression(visualmode())<cr>', mode = 'v' }, -- Extract an expression (variable)
        { '<leader>rm', ':<c-u>call phpactor#ExtractMethod(visualmode())<cr>', mode = 'v' },     -- Extract a method
        { '<Leader>nc', ':PhpactorClassNew<CR>' },
        { '<Leader>mf', ':PhpactorMoveFile<CR>' },
        { '<Leader>fu', ':PhpactorFindReferences<CR>' },
    }
}
