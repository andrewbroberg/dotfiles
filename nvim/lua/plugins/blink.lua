return {
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets',
        'Kaiser-Yang/blink-cmp-avante',
    },

    version = '*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'super-tab',
        },
        completion = {
            menu = {
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind_icon", gap = 1 },          -- keep the nice icon
                        { "source_name", gap = 1 },        -- NEW: shows “Laravel”, “Avante”, “LSP”… 
                    },
                },
            },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
        },

        sources = {
            default = {'laravel', 'avante', 'lsp', 'path', 'snippets', 'buffer' },
            providers = {
                avante = {
                    module = 'blink-cmp-avante',
                    name = 'Avante',
                    opts = {

                    },
                },
                laravel = {
                    name = "Laravel",
                    module = "laravel.blink_source",
                    transform_items = function(ctx, items)
                        for _, item in ipairs(items) do
                            item.kind_icon = ""
                            item.kind_name = "Laravel"
                        end
                        return items
                    end,
                },
            },
        },
    },
    opts_extend = { "sources.default" }
}
