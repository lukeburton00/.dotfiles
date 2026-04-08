vim.pack.add({
    "https://github.com/stevearc/conform.nvim",
})

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        go = { "gofumpt", "goimports-reviser" },
        ruby = { "rubocop" },
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
    format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        return { timeout_ms = 500 }
    end,
    formatters = {
        ["goimports-reviser"] = {
            prepend_args = {
                "-company-prefixes",
                os.getenv("COMPANY_PREFIX"),
                "-imports-order",
                "std,project,company,general",
            },
        },
    },
})

-- Enable or disable format-on-save
vim.api.nvim_create_user_command("FormatDisable", function()
    vim.g.disable_autoformat = true
end, {
    desc = "Disable autoformat-on-save",
    bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
    vim.g.disable_autoformat = false
end, {
    desc = "Re-enable autoformat-on-save",
})
