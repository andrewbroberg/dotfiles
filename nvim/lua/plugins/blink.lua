return {
    'saghen/blink.cmp',
    dependencies = {
        'Kaiser-Yang/blink-cmp-avante',
        { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    },

    version = '*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'super-tab',
        },
        snippets = { preset = 'luasnip' },
        completion = {
            menu = {
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind_icon", gap = 1 },
                        { "source_name", gap = 1 }
                    },
                },
            },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
        },

        sources = {
            default = {'lsp', 'path', 'snippets', 'buffer' },
            providers = {
                -- laravel = {
                --     name = "laravel",
                --     module = "laravel.blink_source",
                --     transform_items = function(ctx, items)
                --         for _, item in ipairs(items) do
                --             item.kind_icon = ""
                --             item.kind_name = "Laravel"
                --         end
                --         return items
                --     end,
                -- },
            },
        },
    },
    opts_extend = { "sources.default" }
}
