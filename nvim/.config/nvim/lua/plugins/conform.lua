return {
    "stevearc/conform.nvim",
    opts = {

        formatters_by_ft = {
            lua = { "stylua" },
            go = { "gofumpt", "goimports-reviser" },
            ruby = { "rubyfmt" },
            nix = { "alejandra" },
            c = { "clang-format" },
            cpp = { "clang-format" },
            cmake = { "cmake_format" },
            rust = { "rustfmt" },
            typescript = { "prettierd" },
            elixir = { "mix" },
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
    },
}
