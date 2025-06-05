return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },

    event = "VeryLazy",

    config = function()
        require("codecompanion").setup({
            display = {
                diff = {
                    enabled = true,
                    provider = "mini_diff", -- Use 'mini_diff' for inline diffs
                    layout = "vertical", -- Options: 'vertical' or 'horizontal'
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
        })

        vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionActions<cr>")
        vim.keymap.set({ "n", "v" }, "<leader>ct", "<cmd>CodeCompanionChat Toggle<cr>")
        vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>")

        -- Expand 'cc' into 'CodeCompanion' in the command line
        vim.cmd([[cab cc CodeCompanion]])
    end,
}
