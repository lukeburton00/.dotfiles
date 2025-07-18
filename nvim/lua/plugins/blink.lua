return {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    event = "InsertEnter",
    version = "*",
    opts = {
        keymap = {
            preset = "enter",
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },
        completion = {
            list = {
                selection = {
                    preselect = false,
                    auto_insert = false,
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                window = { border = "single" },
            },
            ghost_text = { enabled = true },
            menu = { border = "single" },
        },

        signature = {
            enabled = true,
            window = {
                border = "single",
                show_documentation = true,
            },
        },
    },
    opts_extend = { "sources.default" },
}
