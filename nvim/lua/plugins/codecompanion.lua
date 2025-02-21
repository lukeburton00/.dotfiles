return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },

    event = 'VeryLazy',

    config = function ()
        require("codecompanion").setup({
            strategies = {
                chat = {
                    adapter = "openai"
                },
                inline = {
                    adapter = "openai"
                }
            }
        })
    end
}
