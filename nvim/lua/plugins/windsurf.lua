return {
    "Exafunction/windsurf.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    event = "InsertEnter",

    config = function()
        require("codeium").setup({
            enable_cmp_source = false,
            virtual_text = {
                enabled = true,
                manual = false,
            },
        })

        vim.g.codeium_model = "SWE-1-lite"
    end,
}
