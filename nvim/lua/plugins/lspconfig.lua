return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
    },
    event = "BufReadPre",
    config = function()
        vim.lsp.config("*", {
            capabilities = require("blink.cmp").get_lsp_capabilities(),
        })

        vim.lsp.enable({
            "gopls",
            "lua_ls",
            "basedpyright",
            "rust_analyzer",
            "zls",
            "clangd",
            "angularls",
            "ts_ls",
            "html",
            "ruby_lsp",
            "csharp_ls",
            "sourcekit",
            "gdscript",
            "neocmake",
            "yamlls"
        })

        vim.keymap.set("n", "gk", vim.diagnostic.open_float, { desc = "Open Diagnostic Float" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
    end,
}
