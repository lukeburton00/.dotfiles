return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "echasnovski/mini.nvim",
    },
    cmd = { "CodeCompanion" },
    keys = {
        { mode = { "n", "v" }, "<leader>cc", "<cmd>CodeCompanion<cr>", desc = "CodeCompanion" },
        { mode = { "n", "v" }, "<leader>ct", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion Chat" },
        { mode = "v", "ga", "<cmd>CodeCompanionChat Add<cr>", desc = "CodeCompanion Chat Add" },
    },
    opts = {
        display = {
            diff = {
                enabled = true,
                provider = "mini_diff",
                layout = "vertical",
                opts = {
                    "internal",
                    "filler",
                    "closeoff",
                    "algorithm:patience",
                    "followwrap",
                    "linematch:120",
                },
            },
        },
        strategies = {
            chat = {
                adapter = "openai",
            },
            inline = {
                adapter = "openai",
            },
        },
    },
}
