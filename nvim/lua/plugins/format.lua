return {
    "zapling/mason-conform.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        { "stevearc/conform.nvim", opts = {} }
    },

    config = function()
        require("conform").setup({
            formatters_by_ft = {
                go = { "gofumpt" },
                ruby = { "rubocop" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        })

        require("mason-conform").setup({
            ignore_install = {
                "rubocop",
            }
        })
    end

}
