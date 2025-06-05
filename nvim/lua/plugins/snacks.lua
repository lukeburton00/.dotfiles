return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
        quickfile = { enabled = true },
        input = { enabled = true },
        lazygit = { enabled = true },
        picker = {
            win = {
                input = {
                    keys = {
                        ["<Tab>"] = { "list_down", mode = { "i", "n" } },
                        ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
                    },
                },
            },
        },
    },

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
                "<leader>g",
                function()
                    Snacks.lazygit()
                end,
                desc = "LazyGit",
            },
        }
    end,
}
