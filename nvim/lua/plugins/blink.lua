return {
    "saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    event = "InsertEnter",
    version = "1.*",
    opts = {
        enabled = function()
            return not vim.tbl_contains({ "AgenticInput" }, vim.bo.filetype)
        end,
        keymap = {
            preset = "none",
            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
            ["<CR>"] = { "select_and_accept", "fallback" },
            ["<Esc>"] = {
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc><Esc>", true, false, true), "i", false),
            },
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
                auto_show_delay_ms = 250,
                window = { border = "rounded" },
            },
            ghost_text = { enabled = true },
            menu = {
                border = "rounded",
                draw = {
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                                return kind_icon
                            end,
                            highlight = function(ctx)
                                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                                return hl
                            end,
                        },
                        kind = {
                            highlight = function(ctx)
                                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                                return hl
                            end,
                        },
                    },
                },
            },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
        signature = {
            enabled = true,
            window = { border = "rounded", show_documentation = true },
        },
    },
    opts_extend = { "sources.default" },
}
