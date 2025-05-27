return {
    'neovim/nvim-lspconfig',
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },

    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup {
            ensure_installed = {
                "lua_ls",
                "pyright",
                "rust_analyzer",
                "zls",
                "clangd",
                "gopls",
                "angularls"
            },
        }

        vim.lsp.config("*", {
            capabilities = require('blink.cmp').get_lsp_capabilities(capabilities),
        })

        vim.lsp.config("sourcekit", {
            cmd = { "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp" }
        })

        vim.lsp.enable("sourcekit")
        vim.lsp.enable("ruff", false)

        vim.keymap.set("n", "gof", vim.diagnostic.open_float, { desc = "Open Diagnostic Float" })
    end
}
