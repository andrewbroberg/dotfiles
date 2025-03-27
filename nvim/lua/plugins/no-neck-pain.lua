return {
    'shortcuts/no-neck-pain.nvim',
    version = "*",
    opts = {
        width = 200,
        autocmds = {
            enableOnVimEnter = false,
        },
        integrations = {
            NeoTree = {
                position = "floating",
                reopen = true,
            },
            undotree = {
                position = "left",
            },
            neotest = {
                position = "right",
                reopen = true,
            },
            TSPlayground = {
                position = "right",
                reopen = true,
            },
            NvimDAPUI = {
                position = "right",
                reopen = true,
            },
        },
    }

}
