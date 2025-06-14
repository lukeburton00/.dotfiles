return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    keys = function()
        local Snacks = require("snacks")
        return {
            {
                "<leader>f",
                function()
                    Snacks.picker.files()
                end,
                desc = "Find Files",
            },
            {
                "<leader>l",
                function()
                    Snacks.picker.grep()
                end,
                desc = "Grep",
            },
            {
                "<leader>ce",
                function()
                    Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
                end,
                desc = "Config Edit",
            },
            {
                "<leader>r",
                function()
                    Snacks.picker.lsp_references()
                end,
                desc = "View References",
            },
            {
                "<leader>hk",
                function()
                    Snacks.picker.keymaps()
                end,
                desc = "Keymaps",
            },
            {
                "<leader>hh",
                function()
                    Snacks.picker.help()
                end,
                desc = "Help Pages",
            },
            {
                "<leader>qf",
                function()
                    local picker = Snacks.picker.get()
                    Snacks.picker.actions.qflist(picker)
                end,
                desc = "Help Tags",
            },
            {
                "<leader>g",
                function()
                    Snacks.lazygit()
                end,
                desc = "LazyGit",
            },
            {
                "<leader>z",
                function()
                    Snacks.zen()
                end,
                desc = "Zen",
            },
        }
    end,

    opts = {
        quickfile = { enabled = true },
        input = { enabled = true },
        lazygit = { enabled = true },
        dashboard = { enabled = true },
        zen = { enabled = true },
        picker = {
            win = {
                input = {
                    keys = {
                        ["<Tab>"] = { "list_down", mode = { "i", "n" } },
                        ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
                        ["<leader>qf"] = {
                            "qflist",
                            mode = { "n", "i" },
                            desc = "Send all to quickfix",
                        },
                    },
                },
            },
        },

        styles = {
            zen = {
                backdrop = {
                    transparent = false,
                },
            },
        },
    },
}
